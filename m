From: Chao Yu <yuchao0@huawei.com>
Subject: Re: f2fs: SIT corruption upon fsck
Date: Thu, 18 Apr 2019 17:31:28 +0800
Message-ID: <1b88161a-a6ea-4106-fc6e-76b9735d1198@huawei.com>
References: <CAD14+f2sT6HbP-vjwWo6A2O151hF=NqcP6_QqLEiEQaZ=QMgoQ@mail.gmail.com>
 <CAD14+f2oNaVbL6X_oHV=C4JMQMBCtH52OY6SSLEAXisza7fANQ@mail.gmail.com>
 <CAD14+f03GwTORdNyKEXo73pTW_1osGfnq6t68mN8w=ipZDrnrQ@mail.gmail.com>
 <20190417141513.GC23731@jaegeuk-macbookpro.roam.corp.google.com>
 <20190417155131.GA33751@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hH3ON-0006Je-NL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Apr 2019 09:31:39 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hH3OL-00E4sb-L6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Apr 2019 09:31:39 +0000
In-Reply-To: <20190417155131.GA33751@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019/4/17 23:51, Jaegeuk Kim wrote:
> On 04/17, Jaegeuk Kim wrote:
>> Hi Ju Hyung,
>>
>> On 04/17, Ju Hyung Park wrote:
>>> Oh sorry, I should have been more careful attaching the kernel log.
>>> Disregard anything before 3091s mark and just pay attention to those 2 lines:
>>>
>>>> [ 3091.204798] F2FS-fs (loop1): SIT is corrupted node# 2481418 vs 2517451
>>>> [ 3091.204801] F2FS-fs (loop1): Failed to initialize F2FS segment manager
>>
>> Could you please bisect f2fs-tools first to see whether there is any wrong
>> patch? I feel like fsck is corrupting something.
> 
> nvm. I shoot the email too early. It seems that large_nat_bitmap gave old NAT
> set somehow, so that NAT points the previous checkpointed node blocks, since
> SSA were obsolete and some SIT were valid and others were invalid.
> 
> When considering no node block was missing from dentry, I think GC was doing
> between two checkpoints.
> 
> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> [FSCK] SIT valid block bitmap checking                [Fail]
> [FSCK] Hard link checking for regular file            [Ok..] [0x7]
> [FSCK] valid_block_count matching with CP             [Fail] [0x215805c]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x2669cb]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x2669cb]
> [FSCK] valid_inode_count matched with CP              [Ok..] [0x260f23]
> [FSCK] free segment_count matched with CP             [Fail] [0xee6c]
> [FSCK] next block offset is free                      [Ok..]
> 
> 
> Chao,
> 
> BTW, why can't fsck fix this in large_nat_bitmap? Could you check the feature

I found that after repairing corrupted image in where large_nat_bitmap is
enabled, we will lose CP_LARGE_NAT_BITMAP_FLAG flag, result in loading sit
bitmap area with incorrect offset in kernel side.

I've sent a patch to fix this issue.

> in kernel side as well?

But there is another design problem, once nat_bitmap_size + sit_bitmap_size is
larger than MAX_BITMAP_SIZE_IN_CKPT, nat_bitmap or sit_bitmap may overlap
checkpoint checksum's position, whenever checkpoint is written, bitmap will be
damaged...

	if (is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
		offset = (flag == SIT_BITMAP) ?
			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
		return &ckpt->sit_nat_version_bitmap + offset;
	}

Ju Hyung's image size is 256GB, nat bitmap size is 3648 bytes, sit bitmap size
is 320 bytes, checksum position locates at sit_bitmap[252,255], so for those
segments which segno is in range of:

252 * 8 * 55 + 383 (# of meta_seg) = 111263
256 * 8 * 55 + 383 (# of meta_seg) = 113023

Their SIT may not be correct due to corrupted sit_bitmap.

>From the fsck log, it looks that can match the above analyzing of root cause.

[FIX] (is_valid_ssa_data_blk: 321)  --> Set data summary 0x1b329 -> [0x22dda4]
[0x0] [0x0]

corrupted segno: 0x1b329 = 111401

...
[FIX] (is_valid_ssa_data_blk: 321)  --> Set data summary 0x1b68d -> [0x22f811]
[0x0] [0x103]

corrupted segno: 0x1b68d = 112269

...


Sorry to introduce that bug.... let me take some time to fix.


Thanks,

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
