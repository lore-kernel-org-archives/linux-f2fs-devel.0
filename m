From: Chao Yu <yuchao0@huawei.com>
Subject: Re: f2fs: WARNING: at fs/f2fs/segment.c:718
 update_sit_entry+0x1c0/0x2b0()
Date: Mon, 28 Aug 2017 17:21:35 +0800
Message-ID: <a05bee6c-5766-fb95-1ac7-abcbdf1a3176@huawei.com>
References: <f8e749a4-d01a-2247-a215-e8363762fb81@linux-ipv6.be>
 <20170823203746.GA45152@jaegeuk-macbookpro.roam.corp.google.com>
 <bc0b328e-b5c0-2d04-e8bd-7de8e5887096@linux-ipv6.be>
 <20170824190236.GA10428@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dmGF3-0001yo-GU
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Aug 2017 09:21:57 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dmGF1-0005B3-Jh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Aug 2017 09:21:57 +0000
In-Reply-To: <20170824190236.GA10428@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Stijn Tintel <stijn@linux-ipv6.be>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/8/25 3:02, Jaegeuk Kim wrote:
> On 08/24, Stijn Tintel wrote:
>> On 23-08-17 23:37, Jaegeuk Kim wrote:
>>> Thank you for the report.
>>> Could you please test this patch?
>> That seems to fix it, thanks!
>>>
>>> From 440e8638c5b4a7e7bd1234ea1e7da20ce226112e Mon Sep 17 00:00:00 2001
>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>>> Date: Wed, 23 Aug 2017 13:33:00 -0700
>>> Subject: [PATCH] mkfs.f2fs: fix missing cpu_to_le64 for checkpoint version
>>>
>>> The error on mips was reported by Stjin as follow.
>> Minor nit about a typo ;-)
> 
> Oh, sorry. Merged with fix. Thank you~
> 
>>>
>>> Commit 8399a29df92d6867d226df362edbf2e0efa527c1 in f2fs-tools
>>> ("mkfs.f2fs: give random checkpoint version") causes a bug when mounting
>>> a filesystem created with it on a MIPS64 device running a 4.4(.83)
>>> kernel. The following kernel warning appears several times per second,
>>> for 30 seconds:
>>>
>>> [   23.837262] ------------[ cut here ]------------
>>> [   23.842039] WARNING: CPU: 0 PID: 935 at fs/f2fs/segment.c:718
>>> update_sit_entry+0x1c0/0x2b0()
>>> [   23.850507] Modules linked in: pppoe ppp_async l2tp_ppp iptable_nat
>>> [   24.174064] Call Trace:
>>> [   24.176527] [<ffffffff81126e14>] show_stack+0x68/0xb4
>>> [   24.181595] [<ffffffff81321fc4>] dump_stack+0x8c/0xc4
>>> [   24.186660] [<ffffffff8113d004>] warn_slowpath_common+0xa0/0xd0
>>> [   24.192597] [<ffffffff812e0148>] update_sit_entry+0x1c0/0x2b0
>>> [   24.198353] [<ffffffff812e0a70>] refresh_sit_entry+0x70/0xf8
>>> [   24.204022] [<ffffffff812e251c>] allocate_data_block+0x1f0/0x310
>>> [   24.210038] [<ffffffff812e28d8>] do_write_page+0x29c/0x2bc
>>> [   24.215532] [<ffffffff812e2a88>] write_data_page+0xa0/0xd8
>>> [   24.221028] [<ffffffff812d844c>] do_write_data_page+0xe4/0x384
>>> [   24.226870] [<ffffffff812d88f4>] f2fs_write_data_page+0x208/0x464
>>> [   24.232972] [<ffffffff812d5184>] __f2fs_writepage+0x1c/0x74
>>> [   24.238553] [<ffffffff812d54dc>]
>>> f2fs_write_cache_pages.constprop.7+0x250/0x394
>>> [   24.245869] [<ffffffff812d57f4>] f2fs_write_data_pages+0x130/0x1b0
>>> [   24.252066] [<ffffffff811a9f80>] __filemap_fdatawrite_range+0xa0/0xd4
>>> [   24.258515] [<ffffffff812d2338>] sync_dirty_dir_inodes+0x94/0xd8
>>> [   24.264530] [<ffffffff812d2484>] write_checkpoint+0x108/0xb9c
>>> [   24.270283] [<ffffffff812cc398>] f2fs_sync_fs+0x68/0xb0
>>> [   24.275526] [<ffffffff812c641c>] f2fs_sync_file+0x2e8/0x518
>>> [   24.281107] [<ffffffff81213ff4>] do_fsync+0x38/0x70
>>> [   24.285992] [<ffffffff812142e8>] SyS_fsync+0x14/0x20
>>> [   24.290972] [<ffffffff81103950>] syscall_common+0x34/0x58
>>> [   24.296372]
>>> [   24.298096] ---[ end trace fd3ac44449b218ab ]---
>>>
>>> Fix: 8399a29df92d68 ("mkfs.f2fs: give random checkpoint version")
>>> Reported-by: Stijn Tintel <stijn@linux-ipv6.be>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Tested-by: Stijn Tintel <stijn@linux-ipv6.be>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

>>> ---
>>>  mkfs/f2fs_format.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>> index 92876b8..b379e80 100644
>>> --- a/mkfs/f2fs_format.c
>>> +++ b/mkfs/f2fs_format.c
>>> @@ -546,7 +546,7 @@ static int f2fs_write_check_point_pack(void)
>>>  	}
>>>  
>>>  	/* 1. cp page 1 of checkpoint pack 1 */
>>> -	cp->checkpoint_ver = rand() | 0x1;
>>> +	cp->checkpoint_ver = cpu_to_le64(rand() | 0x1);
>>>  	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
>>>  	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
>>>  	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
