From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH] f2fs: fix recover orphan inodes
Date: Thu, 26 Feb 2015 07:04:07 +0800
Message-ID: <20150225230407.GA7267@kernel>
References: <1424840017-97604-1-git-send-email-wanpeng.li@linux.intel.com>
	<20150225183403.GA51593@jaegeuk-mac02.mot.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YQlHq-0006sr-0y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 23:22:38 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQlHo-00012H-AR for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Feb 2015 23:22:37 +0000
Content-Disposition: inline
In-Reply-To: <20150225183403.GA51593@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,
On Wed, Feb 25, 2015 at 10:35:23AM -0800, Jaegeuk Kim wrote:
>Hi Wanpeng,
>
>On Wed, Feb 25, 2015 at 12:53:37PM +0800, Wanpeng Li wrote:
>> recover_orphan_inodes is used to recover orphan inodes, the meta pages 
>> which readahead should be orphan_blkaddr - start_blk instead of orphan_blkaddr.
>> This patch fix it.
>> 
>> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
>> ---
>>  fs/f2fs/checkpoint.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index e6c271f..0f42ff3 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -468,9 +468,9 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>  		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
>
>Actually it seems the name, orphan_blkaddr, was wrong.
>That should be orphan_blocks which is no need to fix like this.
>
>Instead, I found there is another bug below.
>
>>  	orphan_blkaddr = __start_sum_addr(sbi) - 1;
>        orphan_blocks = __start_sum_addr(sbi) - 1 - 
>			le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);

Indeed, I will send a patch to fix it.

>
>It may help to define a macro to get cp_payload.
>

Will do. Thanks for your help. ;-)

Regards,
Wanpeng Li 

>>  
>> -	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
>> +	ra_meta_pages(sbi, start_blk, orphan_blkaddr - start_blk, META_CP);
>
>The orphan_blocks is enough. No need to fix this.
>
>>  
>> -	for (i = 0; i < orphan_blkaddr; i++) {
>> +	for (i = 0; i < orphan_blkaddr - start_blk; i++) {
>
>ditto.
>
>Thanks,

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
