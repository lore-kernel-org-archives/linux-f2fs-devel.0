Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D410C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Dec 2021 01:06:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n36NZ-0000Ly-GE; Fri, 31 Dec 2021 01:06:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <shacharr@gmail.com>) id 1n36NY-0000Ls-B0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Dec 2021 01:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3yQ0lyfMsNWxiMLxC7em/5nNtO4aymAyCuSjy0PLjqE=; b=DfYXk+hibohGY9SWA+4BSpletg
 dw1QX3P+T/5gUkLq5RMvwZCDCXevLG7F1R+jhIvi9DBXEZ7uZOI9jBPA3t+26JJoR0PWwEpTKegg6
 Uk9+4gqgkrLUZPYYIGcnNjb/mr4D3CngTM99/fhRoEHY+NID5CUdzQL5E4rpfB7dM2Mo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3yQ0lyfMsNWxiMLxC7em/5nNtO4aymAyCuSjy0PLjqE=; b=KsjzRLR4xaLM8h9cIK9gqwpPl3
 QCz+rIqeZDyMfyjzZyG42vIbiQE3PGkSur5nH627HcVovfMjFT9jD6gdAL4KnqLxNtkveds7pA+sM
 NonjJCSjU4GV1Y/25XRw//QZfOxCQfTBMb7NpMdXnWS1mInlFWpPwE46VMTt/oGbiEQ8=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1n36NV-00ELF7-7f
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Dec 2021 01:06:45 +0000
Received: by mail-ed1-f41.google.com with SMTP id j21so103764696edt.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Dec 2021 17:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3yQ0lyfMsNWxiMLxC7em/5nNtO4aymAyCuSjy0PLjqE=;
 b=SLc0c5KYaStYakowoSGrDCyr+GCKo0gvXAK3yjZoe0eCjK0tvsYkX8SeaOeqLgv+VS
 rLeF/GiD7XZRyhmcw9sbXDVKeeFFi08zWDH4onV3aJ4ry+5CCLd0uBxfzu6r4ktM6RzF
 1NK6NtrifweJfmVuXC/QYhj0g7YvHAd5gPZN9RZbCAnbjuQ9CQSqNbN9D4NPnQc/G1WD
 7NNrV6CRid2kEA/D7bTxlDEiyDAHGe54qe6KO+/PDBtEyxMqzDrKkHk5OxYfELyg2sx3
 UZpUxupvmLWBQ7JSO3HqaOpa9AbeeURK75MlHGL+LMoRGAUT86pcp38ZCUqIW0jkMt7G
 X7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3yQ0lyfMsNWxiMLxC7em/5nNtO4aymAyCuSjy0PLjqE=;
 b=vIC8qSkbGBmIkyXwyW6+8nlcu+kvCh+LPHhjqNaq7IrvhnsFRedSkogutsSMqSxuV9
 wLckTvsjkEuGFraXa/zH64qeVbFOeRn1wUnoTQ+Mo7GCZmbRtFeXAw8spePIZSs75yLe
 2x9mwihJVzmmnbRgBte4XvfVv8SfUv42x6wRNteMkN+VapUIEXzqBWe8dTQ1hy68Ickk
 51kuKw1onXgFEUCIwwYUBBCbaikPUfB/SUNN9QobUqaNwfx97MeozkB4cYaZccaIC/gp
 XKyjC1KY5Kb9sb1y8iTcZ6dRR3hGkEv52Nze/DOWcGgE8ZbjaseWsrEqWbJOJ7E29uJm
 ySdA==
X-Gm-Message-State: AOAM5304N1k/Yu+ij9qCTnnLc511Eyds7IR1rM7iyLkCflFxi7yp6Wmn
 VPaJAeK33vL3ycxTb3QpdldngDfh5tZStMwLhgGWldTp1LU=
X-Google-Smtp-Source: ABdhPJyo68+ChNlP6cqot2N18ioE6wTAVKtpFUVqJGqbScez/zNRZ8+jd6QXBTq3VXQ5lPT2OuK0PcljVZ21ydATcds=
X-Received: by 2002:a17:906:3586:: with SMTP id
 o6mr27008922ejb.186.1640912794629; 
 Thu, 30 Dec 2021 17:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20210903023811.3458-1-chao@kernel.org>
In-Reply-To: <20210903023811.3458-1-chao@kernel.org>
From: Shachar Raindel <shacharr@gmail.com>
Date: Thu, 30 Dec 2021 17:06:23 -0800
Message-ID: <CAGZn=28_q5tGd5kL_nU3Tz3_XA+gqODGpP6CKsZB6tKb3dAXtA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1n36NV-00ELF7-7f
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix potential deadlock
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 Yi Zhuang <zhuangyi1@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Somewhat late to the party (i.e. 3 months late), happy mailbox cleanup holidays!

On Thu, Sep 2, 2021 at 8:04 PM Chao Yu <chao@kernel.org> wrote:
>
> As Yi Zhuang reported in bugzilla:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214299
>
Bug report is for kernel 5.3. When I reported very similar deadlock in
google-msm 4.9 tree (
https://lore.kernel.org/linux-f2fs-devel/20201128174124.22397-1-shacharr@gmail.com/t/
), you pointed out that the code was missing commits which removed the
cp_rwsem grabbing (which are also missing from kernel 5.3):


commit 435cbab95e3966cd8310addd9e9b758dce0e8b84
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Thu Apr 9 10:25:21 2020 -0700

     f2fs: fix quota_sync failure due to f2fs_lock_op

commit ca7f76e680745d3b8a386638045f85dac1c4b2f4
Author: Chao Yu <chao@kernel.org>
Date:   Fri May 29 17:29:47 2020 +0800

     f2fs: fix wrong discard space

commit 79963d967b492876fa17c8c2c2c17b7438683d9b
Author: Chao Yu <chao@kernel.org>
Date:   Thu Jun 18 14:36:23 2020 +0800

     f2fs: shrink node_write lock coverage

Is this patch needed with these commits applied?


>
> There is potential deadlock during quota data flush as below:
>
> Thread A:                       Thread B:
> f2fs_dquot_acquire
> down_read(&sbi->quota_sem)
>                                 f2fs_write_checkpoint
>                                 block_operations
>                                 f2fs_look_all
>                                 down_write(&sbi->cp_rwsem)
> f2fs_quota_write
> f2fs_write_begin
> __do_map_lock
> f2fs_lock_op
> down_read(&sbi->cp_rwsem)
>                                 __need_flush_qutoa
>                                 down_write(&sbi->quota_sem)
>
> This patch changes block_operations() to use trylock, if it fails,
> it means there is potential quota data updater, in this condition,
> let's flush quota data first and then trylock again to check dirty
> status of quota data.
>
> The side effect is: in heavy race condition (e.g. multi quota data
> upaters vs quota data flusher), it may decrease the probability of
> synchronizing quota data successfully in checkpoint() due to limited
> retry time of quota flush.
>
> Reported-by: Yi Zhuang <zhuangyi1@huawei.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

As this patch is applied in the mainline kernel, can we CC -stable to
get this patch into the various Android kernels? Specifically,
https://android.googlesource.com/kernel/msm/+/refs/tags/android-12.0.0_r0.21/fs/f2fs/checkpoint.c#1147
needs this patch (alongside many other google-msm kernel branches).

Thanks,
--Shachar


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
