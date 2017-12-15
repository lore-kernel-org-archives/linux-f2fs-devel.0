From: "gaoxiang (P)" <gaoxiang25@huawei.com>
Subject: Re: question about find_next_free_block in f2fs-tools
Date: Fri, 15 Dec 2017 07:55:49 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCB14B8@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1ePkr7-0003RB-6B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 07:56:29 +0000
Received: from [45.249.212.255] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ePkr4-0008JM-UZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 07:56:29 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: hutj <hutj@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Jaegeuk,

	ping.. I am reading f2fs-tools and doing some work on it. Could you give me some hints if section has 2 or more segments in f2fs?
	1) the whole section should have the same type? I think so since GC operates sections and I have observed some clues in "get_new_segment":

	skip_left:
	        hint = secno;
	        segno = secno * sbi->segs_per_sec;
	        zoneno = secno / sbi->secs_per_zone;

	It seems that the whole section type is depended on the first segment type in the whole section.
	In that case the following code snippet makes sense:

	if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec)) {
		...
	}

	However, I still cannot understand 

 	if (se->type == type && !f2fs_test_bit(offset, (const char *)se->cur_valid_map))
 		return 0;

	It seems that "se" is not the first segment of the section? How to keep se->type valid? Could you give me some clues?

	2) why should "move_curseg_info" be called at the end of sload. I guess bacause of the chain of forword recovery?

Thanks

> Hi Chao,
> 
> Thanks for your reply.
> 
>> On 2017/12/9 14:29, hsiangkao--- via Linux-f2fs-devel wrote:
>>> Hi Jaegeuk and Chao,
>>>     I have a minor question about the following code snippet in find_next_free_block recently
>>> 		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec)) {
>>> 			struct seg_entry *se2;
>>> 			unsigned int i;
>>> 
>>> 			for (i = 1; i < sbi->segs_per_sec; i++) {
>>> 				se2 = get_seg_entry(sbi, segno + i);
>>> 				if (se2->valid_blocks)
>>> 					break;
>>> 			}
>>> 			if (i == sbi->segs_per_sec)
>>> 				return 0;
>>> 		}
>>>     What does it do if a section has 2 or more segments?
>> 
>> It intends to use free section prior to used one?It is still hard for me to understand. :(
> 
> I guess if some section doesn't satisfy the above condition (means if some segment was used in the section), we just skip those free sections and fail in the worst case rather than fall back again in the case that SSR approach cannot allocate any block?
> 
>> 
>>>     It seems that it succeeds only if the section is totally free? if not, do SSR instead? I have no idea about that. :(
>>>     And the code mainly for SSR follows, but I am confused when I associate that with the above...
>>> 		if (se->type == type &&
>>> 			!f2fs_test_bit(offset, (const char *)se->cur_valid_map))
>>> 			return 0;
>>>     Does that indicate segments of a section should have the same type?
>>>         but I could not find any mechanism to keep segments of a section in the same type.. 
>> 
>> I'm afraid there is no guarantee.
> 
> Hmm... I have no idea...
> 
>> 
>>> 
>>>     And I could not understand what the commit message("fsck.f2fs: LFS alloc_type must have free segment after blkoff") means...
>>>     Why should the last of segment have no valid block in LFS mode?
>> 
>> LFS tries to do allocation from the first block to the last one in opened segment,
>> so if there is any valid block in that segment, there will be collision anyway.
>>
> 
> Yes, I could understand the LFS policy you explained.
> However, the commit message says "LFS alloc_type must have free segment after blkoff" instead of "must have free blocks followed by blkoff".
> That is what I'm confused. :(
> 
> 
> Thanks.
> 
>> Thanks,
>> 
>>> 
>>>     Could you take some time and give me some clues on it... :D
>>> 
>>> Thanks a lot.
>>> 
>>> Gao Xiang
>>> hsiangkao@...
>>> ------------------------------------------------------------------------------
>>> Check out the vibrant tech community on one of the world's most
>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@...
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
