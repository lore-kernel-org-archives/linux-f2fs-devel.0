From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: replace __get_victim by
 dirty_segments in FG_GC
Date: Thu, 23 Feb 2017 19:59:08 +0800
Message-ID: <0e352f22-bacf-82cd-950e-cea91fab7ded@huawei.com>
References: <20170217091639.29433-1-heyunlei@huawei.com>
	<20170217191504.GC2951@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgs3Y-0003mG-EU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:59:32 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgs3U-0001Q3-C2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:59:32 +0000
In-Reply-To: <20170217191504.GC2951@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/18 3:15, Jaegeuk Kim wrote:
> Hi Yunlei,
> 
> I also removed "segno = NULL_SEGNO;" in the beginning part near gc_more.
> 
> Thanks,
> 
> On 02/17, Yunlei He wrote:
>> In FG_GC process, it will search victim section twice. This will
>> cause some dirty section with less valid blocks skip garbage
>> collection.
>>
>> section # 26425 : valid blocks # 3
>> 142.037567: get_victim_by_default: victim 26425 : valid blocks # 3
>> 142.037585: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
>> 142.039494: f2fs_get_victim: dev = (259,30), type = Hot DATA, policy = (Background GC, SSR-mode, Greedy), victim = 19022 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 24
>> 142.070247: new_curseg: Debug: alloc new segment 26746
>> 142.244341: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26054 ofs_unit = 1, pre_victim_secno = 26054, prefree = 0, free = 243
>> 142.254475: do_garbage_collect: Debug: FG_GC, seg_freed = 1
>> 142.293131: f2fs_get_victim: dev = (259,30), type = Warm DATA, policy = (Background GC, SSR-mode, Greedy), victim = 23466 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 244
>> 142.319001: f2fs_get_victim: dev = (259,30), type = Warm DATA, policy = (Background GC, SSR-mode, Greedy), victim = 23467 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 244
>> 142.368879: get_victim_by_default: victim 26425 : valid blocks # 3
>> 142.368894: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
>> 142.378127: f2fs_get_victim: dev = (259,30), type = Hot DATA, policy = (Background GC, SSR-mode, Greedy), victim = 19612 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 24
>> 142.416917: new_curseg: Debug: alloc new segment 26054
>> 142.656794: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 25404 ofs_unit = 1, pre_victim_secno = 25404, prefree = 0, free = 243
>> 142.662139: do_garbage_collect: Debug: FG_GC, seg_freed = 1
>> 142.684159: new_curseg: Debug: alloc new segment 25197
>> 142.685059: get_victim_by_default: victim 26425 : valid blocks # 3
>> 142.685079: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 243
>> 142.701427: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26238 ofs_unit = 1, pre_victim_secno = 26238, prefree = 0, free = 243
>> 142.707105: do_garbage_collect: Debug: FG_GC, seg_freed = 1
>> 142.802444: f2fs_get_victim: dev = (259,30), type = Warm DATA, policy = (Background GC, SSR-mode, Greedy), victim = 23473 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 244
>> 142.804422: get_victim_by_default: victim 26425 : valid blocks # 3
>> 142.804443: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
>> 142.851567: f2fs_get_victim: dev = (259,30), type = Hot DATA, policy = (Background GC, SSR-mode, Greedy), victim = 19092 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 24
>> 142.865014: new_curseg: Debug: alloc new segment 26238
>> 143.082245: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26307 ofs_unit = 1, pre_victim_secno = 26307, prefree = 0, free = 244
>> 143.088252: do_garbage_collect: Debug: FG_GC, seg_freed = 1
>> 143.128307: new_curseg: Debug: alloc new segment 25404
>> 143.181846: get_victim_by_default: victim 26425 : valid blocks # 3
>> 143.181872: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
