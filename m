From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 0/3] f2fs: imporve performance for IPU
Date: Fri, 5 May 2017 09:12:26 +0000
Message-ID: <20170505091229.156181-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d6ZIF-0003nY-KT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:55 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d6ZIC-0007Vm-KD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:55 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Currently, if we do get_node_of_data before f2fs_lock_op, there may be dead lock          
as follows, where process A would be in infinite loop, and B will NOT be awaked.

Process A(cp):            Process B:
f2fs_lock_all(sbi)
                        get_dnode_of_data <---- lock dn.node_page
flush_nodes             f2fs_lock_op

However, in do_write_data_page path, we had better do get_node_of_data first, since
we can check IPU in prior and do IPU without f2fs_lock_op. It make senses for our 
current FSYNC IPU to avoid being blocked by cp. 

What's more, in patch 3), we do IPU if sync io is blocked by cp.


Hou Pengyang (3):
  f2fs: do get_dnode_of_data before f2fs_lock_op
  f2fs: check IPU after reading dnode from disk
  f2fs: try IPU if sync io is blocked by cp

 fs/f2fs/data.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 fs/f2fs/f2fs.h |  6 +++++
 fs/f2fs/node.c |  1 +
 3 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
