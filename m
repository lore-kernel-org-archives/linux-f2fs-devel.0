From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH 3/5] f2fs: format segment_info's show for better
 legibility
Date: Thu, 13 Mar 2014 17:57:37 +0800
Message-ID: <53218111.7040505@cn.fujitsu.com>
References: <5319A2D5.6060201@cn.fujitsu.com> <001801cf3e9c$ac3330d0$04999270$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001801cf3e9c$ac3330d0$04999270$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Kim' <jaegeuk.kim@samsung.com>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,
On 03/13/2014 05:13 PM, Chao Yu wrote:

> Hi Gu,
> 
>> -----Original Message-----
>> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
>> Sent: Friday, March 07, 2014 6:44 PM
>> To: Kim
>> Cc: linux-kernel; f2fs
>> Subject: [f2fs-dev] [PATCH 3/5] f2fs: format segment_info's show for better legibility
>>
>> The original segment_info's show is a bit out-of-format:
>>
>> [root@guz Demoes]# cat /proc/fs/f2fs/loop0/segment_info
>> 0 0 0 0 0 0 0 0 0 0 0
>> 0 0 0 0 0 0 0 0 0 0
>> 0 0 0 0 0 0 0 0 0 0
>> ......
>> 0 0 0 0 0 0 0 0 0 0
>> 0 0 1 0 0 1 [root@guz Demoes]#
>>
>> so we fix it here for better legibility.
>> [root@guz Demoes]# cat /proc/fs/f2fs/loop0/segment_info
>> 0 0 0 0 0 0 0 0 0 0
>> 0 0 0 0 0 0 0 0 0 0
>> 0 0 0 0 0 0 0 0 0 0
>> ......
>> 0 0 0 0 0 0 0 0 0 0
>> 0 0 1 0 0 1
>> [root@guz Demoes]#
> 
> Here is one case, this looks not legible.
> 
> 0 0 0 0 0 0 0 0 0 0
> 1 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 509 512 512 512
> 512 512 512 512 512 512 512 512 512 512
> 512 512 512 512 331 278 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0
> 0 0 0 0 0 0 0 512 512 512
> 512 512 512 512 512 512 512 512 512 512
> 0 512 512 512 512 512 512 1 0 512
> 
> So how about modifying code as following?

> 
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
>> ---
>>  fs/f2fs/super.c |    7 ++++---
>>  1 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 72df734..6e4851c 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -546,11 +546,12 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
>>
>>  	for (i = 0; i < total_segs; i++) {
>>  		seq_printf(seq, "%u", get_valid_blocks(sbi, i, 1));
> 
> 		seq_printf(seq, "%-3u ", get_valid_blocks(sbi, i, 1));

Hmm, this patch has been applied to f2fs-dev tree, so maybe you can send a
patch to enhance it directly!:)

Regards,
Gu

> 
>> -		if (i != 0 && (i % 10) == 0)
>> -			seq_puts(seq, "\n");
>> +		if ((i % 10) == 9 || i == (total_segs - 1))
>> +			seq_putc(seq, '\n');
>>  		else
>> -			seq_puts(seq, " ");
>> +			seq_putc(seq, ' ');
>>  	}
>> +
>>  	return 0;
>>  }
>>
>> --
>> 1.7.7
>>
>>
>> ------------------------------------------------------------------------------
>> Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
>> With Perforce, you get hassle-free workflows. Merge that actually works.
>> Faster operations. Version large binaries.  Built-in WAN optimization and the
>> freedom to use Git, Perforce or both. Make the move to Perforce.
>> http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
