From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH] f2fs: avoid retrying quota flushes while the
 device is congested
Date: Tue, 16 Apr 2019 13:28:13 +0900
Message-ID: <CAD14+f3W1RE+=11pSvVaPJuLizQVHDqX4O-hG=5Cm4+3KE0a+A@mail.gmail.com>
References: <20190415130703.23983-1-qkrwngud825@gmail.com>
 <549ff0f7-6111-e844-d03d-1c3879d4ae36@huawei.com>
 <CAD14+f3DftqxQghh9JwYNc=7jqAMvKqh3qXT8r7P=2Cn6YJ-Qg@mail.gmail.com>
 <5253a5c5-6082-8fc4-0559-eb343b188230@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGFhw-0006rl-Fo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 04:28:32 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGFhu-008vg9-He
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 04:28:32 +0000
Received: by mail-qk1-f195.google.com with SMTP id s81so11327960qke.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Apr 2019 21:28:30 -0700 (PDT)
In-Reply-To: <5253a5c5-6082-8fc4-0559-eb343b188230@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Apr 16, 2019 at 11:51 AM Chao Yu <yuchao0@huawei.com> wrote:
> /* maximum retry quota flush count */
> #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT         8
>
> I added above flush count number to limit cycle index, so that we won't be stuck
> for long time once we are under heavy racy in between checkpoint() and quota
> updating.

I saw this. I actually first attempted increasing this to 16. It didn't fix it.

> Once we skip flushing quota, in current checkpoint, quota sysfile may be
> corrupted, but if there is no sudden power-cut, I expect we can have chance to
> flush all data of quota file in next checkpoint, then the quota file is
> integrated again.
>
> So could you track the root cause why we set the CP_QUOTA_NEED_FSCK_FLAG flag in
> checkpoint() from umount?

Ok, I'll check this out. Please allow me a day or two for this.

> Do we skip flush quota due to flush count exceeds the
> DEFAULT_RETRY_QUOTA_FLUSH_COUNT?

I'll set this to an unrealistic number(e.g. 500) and add a log to check too.

> Could you check your source code? did you apply dfede78aa918 ("fsck.f2fs: detect
> and recover corrupted quota file")? This patch can enable fsck to repair quota
> file corruption once kernel set CP_QUOTA_NEED_FSCK_FLAG flag.

Oh right. Yeah my fsck.f2fs was not up-to-date(pie-release branch).
False alarm.

Thanks.
