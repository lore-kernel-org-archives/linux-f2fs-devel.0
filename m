From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix max orphan inodes calculation
Date: Fri, 27 Feb 2015 17:25:35 +0800
Message-ID: <20150227092535.GA23044@kernel>
References: <1425020704-10355-1-git-send-email-wanpeng.li@linux.intel.com>
 <018001d05271$6cc02c20$46408460$@samsung.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <018001d05271$6cc02c20$46408460$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,
On Fri, Feb 27, 2015 at 05:39:39PM +0800, Chao Yu wrote:
>Hi Wanpeng,
>
>> -----Original Message-----
>> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
>> Sent: Friday, February 27, 2015 3:05 PM
>> To: Jaegeuk Kim
>> Cc: Wanpeng Li; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
>> Subject: [f2fs-dev] [PATCH] f2fs: fix max orphan inodes calculation
>> 
>> cp_payload is introduced for sit bitmap to support large volume, and it is
>> just after the block of f2fs_checkpoint + nat bitmap, so the first segment
>> should include F2FS_CP_PACKS + NR_CURSEG_TYPE + cp_payload + orphan blocks.
>> However, current max orphan inodes calculation don't consider cp_payload,
>> this patch fix it by reducing the number of cp_payload from total blocks of
>> the first segment when calculate max orphan inodes.
>> 
>> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
>> ---
>>  fs/f2fs/checkpoint.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index db82e09..3c9d677 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1109,7 +1109,7 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
>>  	 * for cp pack we can have max 1020*504 orphan entries
>
>The description above should be wrong, can you please update it in this patch?

Ok, I will adjust the comments above the codes.

>
>>  	 */
>>  	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
>> -			NR_CURSEG_TYPE) * F2FS_ORPHANS_PER_BLOCK;
>> +			NR_CURSEG_TYPE - __cp_payload(sbi)) * F2FS_ORPHANS_PER_BLOCK;
>
>There is a trivial coding style issue: "line over 80 characters"

Will fix it.

Regards,
Wanpeng Li 

>
>Thanks,
>
