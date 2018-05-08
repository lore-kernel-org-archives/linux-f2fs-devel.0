From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Hung task when executing generic/256 test
Date: Tue, 08 May 2018 11:56:44 +0530
Message-ID: <2479794.CdILPghxpW@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1fFyp5-00067q-Lx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 May 2018 09:22:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFyp4-009NUA-1E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 May 2018 09:22:15 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w486Onkn081740
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 8 May 2018 02:25:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hu5h6ac9n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 08 May 2018 02:25:08 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Tue, 8 May 2018 07:25:06 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w486P2kL5636586
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 8 May 2018 06:25:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE83A5204B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 May 2018 06:15:22 +0100 (BST)
Received: from localhost.localdomain (unknown [9.199.53.28])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A048452049
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 May 2018 06:15:22 +0100 (BST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

The following "Hung task" information is seen when executing generic/256 test
on next-20180503.

[ 1964.025145] F2FS-fs (loop1): Mounted with checkpoint version = 22d8b4fd
[ 2212.833962] INFO: task umount:16199 blocked for more than 120 seconds.
[ 2212.835736]       Tainted: G        W         4.17.0-rc3-next-20180503-04271-g6eb58cf86baa #1
[ 2212.837944] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2212.840002] umount          D14184 16199  16195 0x00000000
[ 2212.841470] Call Trace:
[ 2212.842211]  ? __schedule+0x28a/0xad0
[ 2212.843234]  schedule+0x2f/0x90
[ 2212.844122]  io_schedule+0x12/0x40
[ 2212.845071]  wait_on_page_bit_common+0xe2/0x160
[ 2212.846159]  ? page_cache_tree_insert+0x130/0x130
[ 2212.846827]  __filemap_fdatawait_range+0xe5/0x150
[ 2212.847473]  ? sync_inodes_sb+0x1ff/0x450
[ 2212.848050]  filemap_fdatawait_keep_errors+0x1a/0x40
[ 2212.848751]  sync_inodes_sb+0x262/0x450
[ 2212.849282]  sync_filesystem+0x57/0x90
[ 2212.849821]  generic_shutdown_super+0x22/0x100
[ 2212.850435]  kill_block_super+0x21/0x50
[ 2212.850989]  deactivate_locked_super+0x2f/0x70
[ 2212.851596]  cleanup_mnt+0x3b/0x70
[ 2212.852092]  task_work_run+0xa1/0xd0
[ 2212.852580]  exit_to_usermode_loop+0x83/0x90
[ 2212.853185]  do_syscall_64+0x157/0x180
[ 2212.853725]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2212.854420] RIP: 0033:0x7fadbca7d357
[ 2212.854935] Code: Bad RIP value.
[ 2212.855384] RSP: 002b:00007ffe15b2bbb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[ 2212.856418] RAX: 0000000000000000 RBX: 0000561162acc2d0 RCX: 00007fadbca7d357
[ 2212.857393] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000561162ad1390
[ 2212.858391] RBP: 0000000000000000 R08: 000000000000fef8 R09: 0000feff00000000
[ 2212.859367] R10: 0000000000000000 R11: 0000000000000246 R12: 0000561162ad1390
[ 2212.860345] R13: 00007fadbd8231a4 R14: 0000561162acc4b0 R15: 00007ffe15b2be28

The following is the contents of the xfstests' local.config file,

# F2FS
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt/xfstest-test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt/xfstest-scratch
MKFS_OPTIONS="-O encrypt"
MOUNT_OPTIONS="-o test_dummy_encryption"

-- 
chandan


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
