From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid retrying quota flushes while the
 device is congested
Date: Tue, 16 Apr 2019 10:51:27 +0800
Message-ID: <5253a5c5-6082-8fc4-0559-eb343b188230@huawei.com>
References: <20190415130703.23983-1-qkrwngud825@gmail.com>
 <549ff0f7-6111-e844-d03d-1c3879d4ae36@huawei.com>
 <CAD14+f3DftqxQghh9JwYNc=7jqAMvKqh3qXT8r7P=2Cn6YJ-Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hGECC-0004uC-Fd
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 02:51:40 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGEC8-007szQ-Sh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 02:51:40 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 7A2BD84AD0A0437D7A25
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Apr 2019 10:51:29 +0800 (CST)
In-Reply-To: <CAD14+f3DftqxQghh9JwYNc=7jqAMvKqh3qXT8r7P=2Cn6YJ-Qg@mail.gmail.com>
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
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Ju Hyung,

On 2019/4/16 10:10, Ju Hyung Park wrote:
> Hi Chao,
> 
> On Tue, Apr 16, 2019 at 10:58 AM Chao Yu <yuchao0@huawei.com> wrote:
>> I knew this works in scenario cell phone suffers sudden power-cut frequently,
>> actually, in a normal case, if there is race in between checkpoint() and quota
>> updater, checkpoint() may suffer longer delay than before.
> 
> This was actually not a sudden power-cut scenario.
> After passing the setup wizard
> (the quota flush timeout might have happened during initial dex2oat process)
> and simply rebooting, I always see "quota file may be corrupted, skip
> loading it".
> 
> I personally investigated this quota corruption issue as I frequently
> saw it on my
> daily driver phone even when I never had sudden power-cuts.

Okay.

> 
>> So I suggest we keep the logic as it is, since sudden power-cut is not a common
>> case,
> 
> As I said, the issue is caused from a totally normal scenario.
> A solution must be implemented imo.
> Feel free to suggest a better idea/patch for me to test with.

retry_flush_quotas:
	if (__need_flush_quota(sbi)) {
		int locked;

		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
			f2fs_lock_all(sbi);
			goto retry_flush_dents;
		}

/* maximum retry quota flush count */
#define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8

I added above flush count number to limit cycle index, so that we won't be stuck
for long time once we are under heavy racy in between checkpoint() and quota
updating.

Once we skip flushing quota, in current checkpoint, quota sysfile may be
corrupted, but if there is no sudden power-cut, I expect we can have chance to
flush all data of quota file in next checkpoint, then the quota file is
integrated again.

So could you track the root cause why we set the CP_QUOTA_NEED_FSCK_FLAG flag in
checkpoint() from umount?
Do we skip flush quota due to flush count exceeds the
DEFAULT_RETRY_QUOTA_FLUSH_COUNT?

> 
>> even in such case, quota sysfile is corrupted, we have another chance to
>> repair it with fsck-tools, right?
> 
> This is an another potential issue. Android does fsck.f2fs -a on boot
> and it does not
> restore quota. Doing a run with -f fixes it, but not with -a.

Could you check your source code? did you apply dfede78aa918 ("fsck.f2fs: detect
and recover corrupted quota file")? This patch can enable fsck to repair quota
file corruption once kernel set CP_QUOTA_NEED_FSCK_FLAG flag.

Thanks,

> 
> This ultimately led the storage settings under the settings app to misbehave.
> 
> Thanks.
> .
> 
