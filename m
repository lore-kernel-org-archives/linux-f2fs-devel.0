From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202749] New: f2fs: possibly fail to pageout because
 PagePrivate is set without increasing page count in .set_page_dirty()
Date: Mon, 04 Mar 2019 14:23:32 +0000
Message-ID: <bug-202749-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h0oVJ-0007RH-HE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 14:23:41 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0oVH-002rhO-KB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 14:23:41 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3F56B2A4D8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  4 Mar 2019 14:23:33 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=202749

            Bug ID: 202749
           Summary: f2fs: possibly fail to pageout because PagePrivate is
                    set without increasing page count in .set_page_dirty()
           Product: File System
           Version: 2.5
    Kernel Version: 5.0 and older
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: hsiangkao@aol.com
                CC: chao@kernel.org, jaegeuk@kernel.org
        Regression: No

Hi,

It seems that f2fs sets PagePrivate in f2fs_set_data_page_dirty to indicate
that it tend to enable corresponding .invalidatepage and .releasepage for these
dirty pages.

However, it seems that it misses to add an extra page count when PagePrivate is
set [1].

Therefore, I guess that it can cause that dirty pages are failed to pageout in
some cases, therefore I changed mm/vmscan.c code to confirm my thought as
follows:


diff --git a/mm/vmscan.c b/mm/vmscan.c
index b247e2c7bbc6..32ee664e686b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -642,8 +642,19 @@ static pageout_t pageout(struct page *page, struct
address_space *mapping,
         * swap_backing_dev_info is bust: it doesn't reflect the
         * congestion state of the swapdevs.  Easy to fix, if needed.
         */
-       if (!is_page_cache_freeable(page))
+       if (!is_page_cache_freeable(page)) {
+               if (page_is_file_cache(page)) {
+                       struct inode *const inode = page->mapping->host;
+
+                       if (inode->i_sb->s_magic == F2FS_SUPER_MAGIC) {
+                               if (PagePrivate(page)) {
+                                       printk(KERN_EMERG "gx: page %px inode
%px page_private %lx count: %d\n", page, inode, page_private(page),
page_count(page));
+                                       WARN_ON(1);
+                               }
+                       }
+               }
                return PAGE_KEEP;
+       }
        if (!mapping) {
                /*
                 * Some data journaling orphaned pages can have



with some fsstress pressures I got the following results:

...
[  123.545939] (3)[117:kswapd0]gx: page ffffffbf9638fe80 inode ffffffe57ea2c618
page_private 0 count: 2
[  123.545962] -(3)[117:kswapd0]------------[ cut here ]------------
[  123.545973] -(3)[117:kswapd0]WARNING: CPU: 3 PID: 117 at
/home/g00380047/mt6761_2/kernel-4.9/mm/vmscan.c:652
shrink_page_list+0x5fc/0xddc
[  123.545980] -(3)[117:kswapd0]Modules linked in:
[  123.545990] -(3)[117:kswapd0]
[  123.546000] -(3)[117:kswapd0]CPU: 3 PID: 117 Comm: kswapd0 Tainted: G       
W       4.9.117+ #144
[  123.546008] -(3)[117:kswapd0]Hardware name: MT6761V/WBB (DT)
[  123.546015] -(3)[117:kswapd0]task: ffffffe54ee68000 task.stack:
ffffffe553158000
[  123.546023] -(3)[117:kswapd0]PC is at shrink_page_list+0x5fc/0xddc
[  123.546031] -(3)[117:kswapd0]LR is at shrink_page_list+0x5fc/0xddc
[  123.546038] -(3)[117:kswapd0]pc : [<ffffff84ce4065d4>] lr :
[<ffffff84ce4065d4>] pstate: 60400145
--
[  123.549730] -(3)[117:kswapd0]b800: 0000000000000059 0000000000040975
0000000000040975 0000000000000001
[  123.549738] -(3)[117:kswapd0]b820: ffffff84d0068b68 ffffffe5bfebe050
0000000000008080 feff64716e73726f
[  123.549746] -(3)[117:kswapd0]b840: 7f7f7f7f7f7f7f7f 0000000000040975
0101010101010101 0000000000000030
[  123.549759] -(3)[117:kswapd0][<ffffff84ce4065d4>]
shrink_page_list+0x5fc/0xddc
[  123.549768] -(3)[117:kswapd0][<ffffff84ce407770>]
shrink_inactive_list+0x2e4/0x548
[  123.549777] -(3)[117:kswapd0][<ffffff84ce4084a0>]
shrink_node_memcg.isra.77+0x7a0/0xad8
[  123.549784] -(3)[117:kswapd0][<ffffff84ce408838>] shrink_node+0x60/0x214
[  123.549792] -(3)[117:kswapd0][<ffffff84ce409438>] kswapd+0x36c/0x640
[  123.549803] -(3)[117:kswapd0][<ffffff84ce2d2164>] kthread+0xec/0x100
[  123.549812] -(3)[117:kswapd0][<ffffff84ce283d70>] ret_from_fork+0x10/0x20
[  123.549908] (3)[117:kswapd0]gx: page ffffffbf9638fec0 inode ffffffe57ea2c618
page_private 0 count: 2
[  123.549932] -(3)[117:kswapd0]------------[ cut here ]------------
[  123.549943] -(3)[117:kswapd0]WARNING: CPU: 3 PID: 117 at
/home/g00380047/mt6761_2/kernel-4.9/mm/vmscan.c:652
shrink_page_list+0x5fc/0xddc
[  123.549951] -(3)[117:kswapd0]Modules linked in:
[  123.549960] -(3)[117:kswapd0]
[  123.549969] -(3)[117:kswapd0]CPU: 3 PID: 117 Comm: kswapd0 Tainted: G       
W       4.9.117+ #144
[  123.549976] -(3)[117:kswapd0]Hardware name: MT6761V/WBB (DT)
[  123.549983] -(3)[117:kswapd0]task: ffffffe54ee68000 task.stack:
ffffffe553158000
[  123.549991] -(3)[117:kswapd0]PC is at shrink_page_list+0x5fc/0xddc
[  123.549999] -(3)[117:kswapd0]LR is at shrink_page_list+0x5fc/0xddc
[  123.550006] -(3)[117:kswapd0]pc : [<ffffff84ce4065d4>] lr :
[<ffffff84ce4065d4>] pstate: 60400145
--
[  123.553776] -(3)[117:kswapd0]b800: 0000000000000059 0000000000040975
0000000000040975 0000000000000001
[  123.553784] -(3)[117:kswapd0]b820: ffffff84d0068b68 ffffffe5bfebe050
0000000000008080 feff64716e73726f
[  123.553793] -(3)[117:kswapd0]b840: 7f7f7f7f7f7f7f7f 0000000000040975
0101010101010101 0000000000000030
[  123.553810] -(3)[117:kswapd0][<ffffff84ce4065d4>]
shrink_page_list+0x5fc/0xddc
[  123.553818] -(3)[117:kswapd0][<ffffff84ce407770>]
shrink_inactive_list+0x2e4/0x548
[  123.553827] -(3)[117:kswapd0][<ffffff84ce4084a0>]
shrink_node_memcg.isra.77+0x7a0/0xad8
[  123.553835] -(3)[117:kswapd0][<ffffff84ce408838>] shrink_node+0x60/0x214
[  123.553842] -(3)[117:kswapd0][<ffffff84ce409438>] kswapd+0x36c/0x640
[  123.553853] -(3)[117:kswapd0][<ffffff84ce2d2164>] kthread+0xec/0x100
[  123.553863] -(3)[117:kswapd0][<ffffff84ce283d70>] ret_from_fork+0x10/0x20
[  123.556520] (3)[117:kswapd0]gx: page ffffffbf96385600 inode ffffffe57ea2c618
page_private 0 count: 2
[  123.556560] -(3)[117:kswapd0]------------[ cut here ]------------
[  123.556579] -(3)[117:kswapd0]WARNING: CPU: 3 PID: 117 at
/home/g00380047/mt6761_2/kernel-4.9/mm/vmscan.c:652
shrink_page_list+0x5fc/0xddc
[  123.556587] -(3)[117:kswapd0]Modules linked in:
[  123.556599] -(3)[117:kswapd0]
[  123.556611] -(3)[117:kswapd0]CPU: 3 PID: 117 Comm: kswapd0 Tainted: G       
W       4.9.117+ #144
[  123.556618] -(3)[117:kswapd0]Hardware name: MT6761V/WBB (DT)
[  123.556625] -(3)[117:kswapd0]task: ffffffe54ee68000 task.stack:
ffffffe553158000
[  123.556634] -(3)[117:kswapd0]PC is at shrink_page_list+0x5fc/0xddc
[  123.556642] -(3)[117:kswapd0]LR is at shrink_page_list+0x5fc/0xddc
[  123.556650] -(3)[117:kswapd0]pc : [<ffffff84ce4065d4>] lr :
[<ffffff84ce4065d4>] pstate: 60400145
--
[  123.560464] -(3)[117:kswapd0]b800: 0000000000000059 0000000000040975
0000000000040975 0000000000000001
[  123.560472] -(3)[117:kswapd0]b820: ffffff84d0068b68 ffffffe5bfebe050
0000000000008080 feff64716e73726f
[  123.560480] -(3)[117:kswapd0]b840: 7f7f7f7f7f7f7f7f 0000000000040975
0101010101010101 0000000000000030
[  123.560493] -(3)[117:kswapd0][<ffffff84ce4065d4>]
shrink_page_list+0x5fc/0xddc
[  123.560502] -(3)[117:kswapd0][<ffffff84ce407770>]
shrink_inactive_list+0x2e4/0x548
[  123.560511] -(3)[117:kswapd0][<ffffff84ce4084a0>]
shrink_node_memcg.isra.77+0x7a0/0xad8
[  123.560518] -(3)[117:kswapd0][<ffffff84ce408838>] shrink_node+0x60/0x214
[  123.560527] -(3)[117:kswapd0][<ffffff84ce409438>] kswapd+0x36c/0x640
[  123.560537] -(3)[117:kswapd0][<ffffff84ce2d2164>] kthread+0xec/0x100
[  123.560547] -(3)[117:kswapd0][<ffffff84ce283d70>] ret_from_fork+0x10/0x20
...


and my random pressures generate from
1. echo 0 > /proc/sys/vm/swappiness
2. run 3 threads with
/data/fsstress -d /data/test -p 1000 -n 10000 -l0 -S -c
on my test low-end Android phone.


[1] for this constraint, see more details in
https://lore.kernel.org/lkml/2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com/
https://lore.kernel.org/lkml/583fba27-cbd7-1f90-8bf0-a3b49e75b0f6@huawei.com/


Thanks,
Gao Xiang

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
