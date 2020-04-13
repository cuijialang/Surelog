/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * File:   PortNetHolder.h
 * Author: alain
 *
 * Created on January 30, 2020, 8:31 PM
 */

#include "Design/Signal.h"

#ifndef PORTNETHOLDER_H
#define PORTNETHOLDER_H

namespace UHDM {
class cont_assign;
class process;
class parameters;
class param_assign;
};

namespace SURELOG {

class PortNetHolder {
public:
    PortNetHolder() : m_contAssigns(NULL), m_processes(NULL), 
                      m_parameters(NULL), m_param_assigns(NULL) {}
    virtual ~PortNetHolder();

    std::vector<Signal*>& getPorts()
    {
        return m_ports;
    }

    std::vector<Signal*>& getSignals()
    {
        return m_signals;
    }

    std::vector<UHDM::cont_assign*>* getContAssigns()
    {
        return m_contAssigns;
    }

    void setContAssigns(std::vector<UHDM::cont_assign*>* cont_assigns)
    {
        m_contAssigns = cont_assigns;
    }
    
    std::vector<UHDM::process*>* getProcesses()
    {
        return m_processes;
    }

    void setProcesses(std::vector<UHDM::process*>* processes)
    {
        m_processes = processes;
    }

    std::vector<UHDM::parameters*>* getParameters()
    {
        return m_parameters;
    }

    void setParameters(std::vector<UHDM::parameters*>* parameters)
    {
        m_parameters = parameters;
    }

    std::vector<UHDM::param_assign*>* getParam_assigns()
    {
        return m_param_assigns;
    }

    void setParam_assigns(std::vector<UHDM::param_assign*>* parameters)
    {
        m_param_assigns = parameters;
    }

protected:
    std::vector<Signal*> m_ports;
    std::vector<Signal*> m_signals;
    std::vector<UHDM::cont_assign*>* m_contAssigns;
    std::vector<UHDM::process*>* m_processes;
    std::vector<UHDM::parameters*>* m_parameters;
    std::vector<UHDM::param_assign*>* m_param_assigns;
};
};

#endif /* PORTNETHOLDER_H */

