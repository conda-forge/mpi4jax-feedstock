
echo "###########################################################"
echo "#############  Executing custom run_test.sh   #############"
echo "###########################################################"

echo "# Running run_test.sh from directory: $(pwd)"
echo "the content of this directory is:"
ls .

export OMPI_MCA_plm=isolated
export OMPI_MCA_btl=self,tcp
export OMPI_MCA_btl_vader_single_copy_mechanism=none
export OMPI_MCA_rmaps_base_oversubscribe=yes

if [ $(uname) == Darwin ]; then
	echo "127.0.0.1 $(sudo scutil --get LocalHostName).local" | sudo tee -a /etc/hosts
	cat /etc/hosts
	sleep 10
fi

echo "###########################################################"
echo "#############  Executing single-proc pytest   #############"
echo "###########################################################"

pytest .

echo "###########################################################"
echo "#############  Executing mpirun -np2 pytest   #############"
echo "###########################################################"
mpirun -host localhost:2 -v -np 2 pytest .
