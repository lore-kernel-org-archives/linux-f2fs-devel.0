From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v2] f2fs: fix max orphan inodes calculation
Date: Fri, 6 Mar 2015 12:46:33 +0800
Message-ID: <20150306044633.GA2871@kernel>
References: <1425029893-24702-1-git-send-email-wanpeng.li@linux.intel.com>
	<20150303014022.GD6541@lcm-devel.org>
	<012301d057bf$029602e0$07c208a0$@samsung.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YTkRU-000537-It
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Mar 2015 05:04:56 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YTkRT-0003od-7P for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Mar 2015 05:04:56 +0000
Content-Disposition: inline
In-Reply-To: <012301d057bf$029602e0$07c208a0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Changman Lee' <cm224.lee@samsung.com>
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 'Jaegeuk Kim' <jaegeuk@kernel.org>

Hi Changman,
On Fri, Mar 06, 2015 at 11:37:28AM +0800, Chao Yu wrote:
>Hi Changman,
>
>> -----Original Message-----
>> From: Changman Lee [mailto:cm224.lee@samsung.com]
>> Sent: Tuesday, March 03, 2015 9:40 AM
>> To: linux-f2fs-devel@lists.sourceforge.net
>> Cc: Jaegeuk Kim; Chao Yu; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2] f2fs: fix max orphan inodes calculation
>> 
>> On Fri, Feb 27, 2015 at 05:38:13PM +0800, Wanpeng Li wrote:
>> > cp_payload is introduced for sit bitmap to support large volume, and it is
>> > just after the block of f2fs_checkpoint + nat bitmap, so the first segment
>> > should include F2FS_CP_PACKS + NR_CURSEG_TYPE + cp_payload + orphan blocks.
>> > However, current max orphan inodes calculation don't consider cp_payload,
>> > this patch fix it by reducing the number of cp_payload from total blocks of
>> > the first segment when calculate max orphan inodes.
>> >
>> > Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
>> > ---
>> > v1 -> v2:
>> >  * adjust comments above the codes
>> >  * fix coding style issue
>> >
>> >  fs/f2fs/checkpoint.c | 12 +++++++-----
>> >  1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> > index db82e09..a914e99 100644
>> > --- a/fs/f2fs/checkpoint.c
>> > +++ b/fs/f2fs/checkpoint.c
>> > @@ -1103,13 +1103,15 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
>> >  	}
>> >
>> >  	/*
>> > -	 * considering 512 blocks in a segment 8 blocks are needed for cp
>> > -	 * and log segment summaries. Remaining blocks are used to keep
>> > -	 * orphan entries with the limitation one reserved segment
>> > -	 * for cp pack we can have max 1020*504 orphan entries
>> > +	 * considering 512 blocks in a segment 8+cp_payload blocks are
>> > +	 * needed for cp and log segment summaries. Remaining blocks are
>> > +	 * used to keep orphan entries with the limitation one reserved
>> > +	 * segment for cp pack we can have max 1020*(504-cp_payload)
>> > +	 * orphan entries
>> >  	 */
>> 
>> Hi all,
>> 
>> I think below code give us information enough so it doesn't need to
>> describe above comments. And someone could get confused by 1020 constants.
>> How do you think about removing comments.
>
>I agree with you.
>
>There are nothing special need to be pay attention for the below statement,
>all meaning of statement could be easily readed as each macro in statement
>can indicate meaning of itself clearly.
>
>So could you send another patch to remove it?

Agreed. You can cleanup it. ;-)

Regards,
Wanpeng Li

>
>Thanks,
>
>> 
>> Regards,
>> Changman
>> 
>> >  	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
>> > -			NR_CURSEG_TYPE) * F2FS_ORPHANS_PER_BLOCK;
>> > +			NR_CURSEG_TYPE - __cp_payload(sbi)) *
>> > +				F2FS_ORPHANS_PER_BLOCK;
>> >  }
>> >
>> >  int __init create_checkpoint_caches(void)
>> > --
>> > 1.9.1
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
