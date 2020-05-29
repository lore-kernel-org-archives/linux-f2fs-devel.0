Return-Path: <SRS0=Qhk5=7L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A5C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 01:51:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9DC2075A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 01:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ItaRwlyQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UKaWvLRe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv3Ro80U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9DC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jeUB7-0001x1-Ho; Fri, 29 May 2020 01:51:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <laoar.shao@gmail.com>) id 1jeUB5-0001wt-52
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 01:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H3h/KKWXDUeQOc5C3bt+8FTDd7C+ZKV4cv02x2eGUM0=; b=ItaRwlyQWpxv9H2UFD279/WPMr
 mR3HcN9P3OSyYBR/En9hQhhT9IrIhFoY3qp1a0NLLRwQDfsQ0TKs2i+xceuVLM2ZDg0zLoDFKw22V
 RAlT+Z7/BGttnFazKh+/R4ghtNRFlzHyxzfNUkhqIOKZGCxu+ASwYIO9oauLjOqotmes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H3h/KKWXDUeQOc5C3bt+8FTDd7C+ZKV4cv02x2eGUM0=; b=UKaWvLReshIt5tqOovojjq8SU4
 mW4dh98qODoULGVNoAYGe4FpPuEqQ2n4HhNV7vprWazluv71EXib3max4VcMWoUHvfKn91HMYGUB6
 +Ez3civHXjW8jLnnpZ9JL/RsPzhma+eriXFfAw4j0L/Lzw4vf6gJf7oFL4rh/CKqe1UQ=;
Received: from mail-il1-f195.google.com ([209.85.166.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jeUB1-00BbVg-8d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 01:51:19 +0000
Received: by mail-il1-f195.google.com with SMTP id 17so977621ilj.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 May 2020 18:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H3h/KKWXDUeQOc5C3bt+8FTDd7C+ZKV4cv02x2eGUM0=;
 b=hv3Ro80UVyre+PN/oxyCxv5Wj3U9Miq4RcYmwn7Wer3m5lna+secRy/iNZy1XU5vs6
 DwjrNtSLHZt3BxA7cIhF92ENeQKAwPhXRCSqVVVGdfZEG1vXKe2rTqhNQ5Hvrpi2UFjd
 LXRB+yKNrnG7mdAT8gMmN500gmHD5X41hEKBe0ZSg81bWVcCF0wDSjdIsr/DX4GRWgtn
 jcsGk9dGIRwLlEPEmqwg9TjN0k2usiunSA7X//YLVJEyZx8FK26kMVPXHvJZ+cbDD4ho
 dfy41JIPsQje/uQaXQhSJnK2rs1lAoB5dKeFYnuDrG4bDMDOculzn8iblXX+9y2QjMdX
 sHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H3h/KKWXDUeQOc5C3bt+8FTDd7C+ZKV4cv02x2eGUM0=;
 b=oiPWi2CeDliQOt+J+BsDihZfH/808Dd5z+cIa8B7Ctq/c41sfZ65LmL/Yn5s2Z4qUJ
 1XnqaQCuHhR6LJYjUEUc/WjMPuZunbm07kohsc8K2kJFG12V2VuozDAyZ6mxew7CwwUv
 Hgeep9LIhkfQ3Mya/QRjR3wUvnBK6aeR/8+XJ97XaP9B36sQqwTM790XgEZnCEZGOu9w
 niW0wkjeEYybJYy/+kAAl8Use+Ghol4B6BkaHew/IJwSDzcLovgMlneqA9nNuFpyauUd
 xJJNdMlzEqrspwrbNtNRYL2gY4qfo0RHVNNOwKYq0l+/oF5eURX7BHCs6PklehT+MNyF
 5QZg==
X-Gm-Message-State: AOAM53329p39GmPd56fGXCoVLBZzctfmrSmb1GULhwbjvxZUOUbKf4OK
 Yv7enIngEKy/B7lAhuv5D+cHEY8U28qlg4txSiX28IgHHFuWWg==
X-Google-Smtp-Source: ABdhPJwOdvRBv/VOCAVzd3CfESY0S+IdHP0T8BAuYkYNjREwWIKEF46vM4w9mjj36My18HtWSo+lPWWNSsKWEHxCsAY=
X-Received: by 2002:a92:770c:: with SMTP id s12mr79501ilc.203.1590717069612;
 Thu, 28 May 2020 18:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
In-Reply-To: <20200528164121.GA839178@chrisdown.name>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 May 2020 09:50:33 +0800
Message-ID: <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
To: Chris Down <chris@chrisdown.name>
X-Headers-End: 1jeUB1-00BbVg-8d
Subject: Re: [f2fs-dev] mm: mkfs.ext4 invoked oom-killer on i386 -
 pagecache_get_page
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
Cc: lkft-triage@lists.linaro.org, Michal Hocko <mhocko@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Cgroups <cgroups@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-block <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, open list <linux-kernel@vger.kernel.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 29, 2020 at 12:41 AM Chris Down <chris@chrisdown.name> wrote:
>
> Naresh Kamboju writes:
> >On Thu, 28 May 2020 at 20:33, Michal Hocko <mhocko@kernel.org> wrote:
> >>
> >> On Fri 22-05-20 02:23:09, Naresh Kamboju wrote:
> >> > My apology !
> >> > As per the test results history this problem started happening from
> >> > Bad : next-20200430 (still reproducible on next-20200519)
> >> > Good : next-20200429
> >> >
> >> > The git tree / tag used for testing is from linux next-20200430 tag and reverted
> >> > following three patches and oom-killer problem fixed.
> >> >
> >> > Revert "mm, memcg: avoid stale protection values when cgroup is above
> >> > protection"
> >> > Revert "mm, memcg: decouple e{low,min} state mutations from protectinn checks"
> >> > Revert "mm-memcg-decouple-elowmin-state-mutations-from-protection-checks-fix"
> >>
> >> The discussion has fragmented and I got lost TBH.
> >> In http://lkml.kernel.org/r/CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com
> >> you have said that none of the added tracing output has triggered. Does
> >> this still hold? Because I still have a hard time to understand how
> >> those three patches could have the observed effects.
> >
> >On the other email thread [1] this issue is concluded.
> >
> >Yafang wrote on May 22 2020,
> >
> >Regarding the root cause, my guess is it makes a similar mistake that
> >I tried to fix in the previous patch that the direct reclaimer read a
> >stale protection value.  But I don't think it is worth to add another
> >fix. The best way is to revert this commit.
>
> This isn't a conclusion, just a guess (and one I think is unlikely). For this
> to reliably happen, it implies that the same race happens the same way each
> time.


Hi Chris,

Look at this patch[1] carefully you will find that it introduces the
same issue that I tried to fix in another patch [2]. Even more sad is
these two patches are in the same patchset. Although this issue isn't
related with the issue found by Naresh, we have to ask ourselves why
we always make the same mistake ?
One possible answer is that we always forget the lifecyle of
memory.emin before we read it. memory.emin doesn't have the same
lifecycle with the memcg, while it really has the same lifecyle with
the reclaimer. IOW, once a reclaimer begins the protetion value should
be set to 0, and after we traversal the memcg tree we calculate a
protection value for this reclaimer, finnaly it disapears after the
reclaimer stops. That is why I highly suggest to add an new protection
member in scan_control before.

[1]. https://lore.kernel.org/linux-mm/20200505084127.12923-3-laoar.shao@gmail.com/
[2]. https://lore.kernel.org/linux-mm/20200505084127.12923-2-laoar.shao@gmail.com/

-- 
Thanks
Yafang


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
