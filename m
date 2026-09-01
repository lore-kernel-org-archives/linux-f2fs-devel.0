Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE85C624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otdBFF+PPvSv5/pKpI9c0U8AkJojeuRVGQENmhavDLs=; b=YoxDPpCuQXQMw3sbuTG00mSTEp
	KWZzo213gJZ12gpSz5smIZGfcIgM4iK3xwKK96QXWgE0vM1qFQN4isrgYsxBBt0ViI3JUJOT6eNkG
	b9MXp/nrNL7QbZ55ii4K0PmYm1X1iEa2LyhFJT1XB8P4BRJBkafiYnvlMC7DfUpIIbxM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RVA-0005tl-C9;
	Tue, 01 Sep 2026 16:38:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RV9-0005td-77
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPl1laDiwoLbLwVrs7S3ts6eE0/WilYt9l17xn2NE1A=; b=ffv6P1W+uJmRXYzK1N0IHI5RIM
 gEzrKPg1pXt+rBFhQ1ajFrnCkz0RCyALr6dX0OzxHeVOKAIrm/p7f63irIk1G5xYNAOOB7qgWa/AH
 MtlZ1FJYqXYMkwniMCVSQG20dszAKmISy9BMokkDT2Nt6/V6+r9NghKUH2LBF8qVFb3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XPl1laDiwoLbLwVrs7S3ts6eE0/WilYt9l17xn2NE1A=; b=gmaaB6llNYaCrWkDuEWv3vzbi0
 rXljSUngx4k6z231lf/PaH1I3VPgx6N64o5kRWUlplX7Tskc0zr6HlWZhf+e4SriYnkKMYnfoqovO
 znQUg1005VW7T7OFPV1IFXZDhJwwc3zMi324Ejhog/udykwXnDEHzh1yqP9TArSUknwY=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RV9-0007Lc-Lz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:23 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a600a1caf8so7972a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280697; cv=none;
 d=google.com; s=arc-20260327;
 b=WyMM6mQTvzoAGuJ7WF5MAou01ahk3TsJC8KqICSngp/Pg4nfMVUDWbG4Ogvv+KWI9N
 KwdEx4Uv4/ju2yFyledxboIlqwnGLpkgIBuaOtkiG/nnUJb/5fqBsz7UcwGoHr3Ph+jF
 3lGwZMmW2Wy1cEoiHjFtYXD0+2DEwc0k3yA/tecctUDqrORgVNWFtGxbDtSBU3ZuaLGx
 xEkY6JO5pzm5vjqOLDvgNM6vGqD6MEziiL6s0lHOGR6LnaVI4D646J+B6leyR02LxFcw
 JxNoWP+Eh1BikLAVM7bKIbo0HzU233k7Smhkma+eZ4PdHLr+6R+uQS+5eqbAW1pLGKBw
 l6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=XPl1laDiwoLbLwVrs7S3ts6eE0/WilYt9l17xn2NE1A=;
 fh=ZZyEDQQrpMGN+93C+nWCKA85F8NlBoZRGypE92/ZoLw=;
 b=UqNDINtzdx7h0HkNX4wAN/ybOllHtLnzcP03hWlIdA/RZ7wkI3ISwMAMRsb491Z45a
 bpBiiiP462I67LMJhttPODIf5rU29pLoQlmr2G0U4bJwLTKC+pm34dRdK6SQxiNRAJS3
 VjG4qaktRyQl4r4Qm4Gvc4aPLmW8UGHu3j/RZ2lMVinTrjE0j1isxPxX8Y07MPWtz6nR
 tp4+FVRuOCSTTdes4I3ZNjXY3PerHSZY+RnkAWMbCrgVILjDWKCpN2mQnzd9HaknK5Qa
 U+kwb04eaTEf+5s2AFJJkUf8IkTKEXaMoZ3pTv7wGbjFISAcq3iA+bYj8VYJDe38wh28
 dNFw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280697; x=1788885497; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XPl1laDiwoLbLwVrs7S3ts6eE0/WilYt9l17xn2NE1A=;
 b=rWwftPB1pQvK4cekhPeVqGCQKHGjaDZ3Po8PBXbs5GVP4E1YZ6LSw1+3AZdy7OYg54
 +C9lKJtG0LvgVO2ttljHq9O6L273xK/zt092aIl0p3mePFW5/K3KDKmpo2cqY6IULv1a
 9N+tuv4SJTKeSN8NnPqySAo13IifzZ8SgfTpllv4hPgq+xG4kzJ8NDMtztJNNQjNCd2S
 qFc8WJ3bhl2aFWdvYjyo538OJ4iMsleOOqbAfHPgy4lUBwApvh56C6QtKy9ZA97v/+7g
 WNpgXxQk2wMSufVBFimtGpa7OX6Z8O7kTQr9MTsMC07zY5wYqCVqoAeQX5plL55WeFLQ
 aPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280697; x=1788885497;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XPl1laDiwoLbLwVrs7S3ts6eE0/WilYt9l17xn2NE1A=;
 b=TiN92/GGFx0cuVDWX9nsS0Gga/dqvU5VDlIAi52QLFn8lAZPsz0vrkV+dXWzy5YGa2
 mFl+X+wwD50xG7O3EX+DEIl/wbzWmQFZwPufEVYSXYSLFlIgYgTYKpOth/uPzHsm3wdA
 eRXxs+138lvui+2GTh+Rp8lyGB3+ZM+rC3hRsO4exBqIl34Ed/Ujm/K0n+ik5ufVDJFj
 s32LUo05jeZYLbf9fluUJPD2NuNgbI3ZsOoPo/YCynqXJoKzzgXQ9qwcLYNVzoL2qorP
 HXS819O1rTnyh1QvfIA7YkU36wNqRxlsn7SkAS1vpqQg+9+dde5n/Z3j39fbnmmBpoFC
 gE8Q==
X-Gm-Message-State: AFuF++n2t+U5OK3ERhmIbIxE7j9S6aMSuRZuy4YcIpvUA1lp1cn2lYVv
 DjyI5pS0mAMc4jP9feTojS9wTmld4ZSXPJYSry8wVypt2zwI7S2jvpjUvcITWg9i6jTiKOPbrPe
 5kHXa0ZoK7a4DuHhPBl4mDL+VmxvZi1Y=
X-Gm-Gg: AYBFou2qjoDYxBAx//c3EtHrNSIjjYy7s0RmEnrv5hq1pLYHQFlMg5KtjjR95g31ND0
 /wGlU2KtdqbP0i20DEhi3G8mZ3JamjX5ay4LlCsfIPOwkm2ai7Il8v+q5AmlnI+GErPRyTyVTPY
 T0Ja8hlQ40F6cOuGd/BmIBDiG6aOrzTUtR8/1q8JwIlI0uGPuiD9TgnJE8j/9V1AwG8cj+VbYia
 /+wvaVtI9f3o+G8TRpduP+/r7SR9vzxM1AvuAUwCEz1MUNYeoaUZbt4hoXPRO1sutHqqW1P5G9p
 Ndb+uzYfcVUHqcvJWWLhLpRM4jIOg2EhzDGnG9W8WK71/3Uw3pFrXXgR0vulnNv9NbW/3UIcdM8
 jJQ==
X-Received: by 2002:a05:6402:2742:b0:6a5:d8f0:dc10 with SMTP id
 4fb4d7f45d1cf-6a60d3c288fmr15898642a12.13.1788280697049; Tue, 01 Sep 2026
 09:38:17 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:16 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:16 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACOAw_ymXA1ytnL0W91B-L2OuuBzz2PRj2tVgZw332kTvO2nZw@mail.gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <65b4a84c4504019ea6b208f424917f9df4eed2dd.1788213716.git.zhangxp1998@gmail.com>
 <CACOAw_ymXA1ytnL0W91B-L2OuuBzz2PRj2tVgZw332kTvO2nZw@mail.gmail.com>
Date: Tue, 1 Sep 2026 09:38:16 -0700
X-Gm-Features: AcwNN1VnMbzO8_bOjpejEQ4zyWY9jNOcKW2EwdC4fvT5AGKXdobXzx3nUqPIQi4
Message-ID: <CAH=xXfG-Xayv+vhFuyBsdaNXhnDLk4mOCY87vn_NrTWLq99Jkg@mail.gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1x1RV9-0007Lc-Lz
Subject: Re: [f2fs-dev] [PATCH v7 07/11] f2fs: describe xattr block layout
 dynamically
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
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks. I have consolidated the two macros into
MAX_INLINE_XATTR_SIZE(blocksize).

For f2fs_parse_param(), I kept F2FS_MAX_BLKSIZE rather than
F2FS_MIN_BLKSIZE because the on-disk block size is not known at that
stage. Using the minimum would incorrectly reject an inline xattr size
that is valid for a 16K-block filesystem. f2fs_check_opt_consistency()
later applies the limit for the actual sbi->blocksize.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
