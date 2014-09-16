From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 4/5] f2fs: fix to clean previous mount option
 when remount_fs
Date: Tue, 16 Sep 2014 11:46:11 +0800
Message-ID: <5417B283.10702@cn.fujitsu.com>
References: <003001cfd0cc$96f9e8e0$c4edbaa0$@samsung.com>
	<54179768.2010708@cn.fujitsu.com>
	<00a001cfd15b$30bdadc0$92390940$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1XTjvo-0002Rf-1O
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Sep 2014 03:59:56 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XTjvm-0002G8-1E for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Sep 2014 03:59:56 +0000
In-Reply-To: <00a001cfd15b$30bdadc0$92390940$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 09/16/2014 11:05 AM, Chao Yu wrote:

> Hi Gu,
> 
>> -----Original Message-----
>> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
>> Sent: Tuesday, September 16, 2014 9:51 AM
>> To: Chao Yu
>> Cc: Jaegeuk Kim; Changman Lee; linux-f2fs-devel@lists.sourceforge.net;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [f2fs-dev][PATCH 4/5] f2fs: fix to clean previous mount option when remount_fs
>>
>> Hi Yu,
>> On 09/15/2014 06:04 PM, Chao Yu wrote:
>>
>>> In manual of mount, we descript remount as below:
>>>
>>> "mount -o remount,rw /dev/foo /dir
>>> After  this call all old mount options are replaced and arbitrary stuff from
>>> fstab is ignored, except the loop= option which is internally generated and
>>> maintained by the mount command."
>>>
>>> Previously f2fs do not clear up old mount options when remount_fs, so we have no
>>> chance of disabling previous option (e.g. flush_merge). Fix it.
>>
>> Please don't.
>> "Remount" should just change what you specified and keep others unchanged.
> 
> Actually, there are two kinds of different 'remount', they are all specified in
> manual of mount.
> 1) mount -o remount,rw /dev/foo /dir
> 2) mount -o remount,rw  /dir

Thanks for your reminder, I confused them.

Regards,
Gu

> 
> I think 'remount' in your description is the second kind, being different from the
> first kind in description of this patch, for the second kind remount, 'mount' command
> can keep old options by loading them from mtab/fstab then merge them with new
> specified options.
> 
> Thanks,
> Yu
> 
>> The problem here is that we need to provide mount opts for disable/enable
>> some features, but we missed it. So the right way is adding these opts if
>> we really need them.
>>
>> Thanks,
>> Gu
>>
>>>
>>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>>> ---
>>>  fs/f2fs/super.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 54444bb..90fcbe0 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -616,6 +616,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>  	org_mount_opt = sbi->mount_opt;
>>>  	active_logs = sbi->active_logs;
>>>
>>> +	sbi->mount_opt.opt = 0;
>>> +	sbi->active_logs = NR_CURSEG_TYPE;
>>> +
>>>  	/* parse mount options */
>>>  	err = parse_options(sb, data);
>>>  	if (err)
> 
> 
> .
> 



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
