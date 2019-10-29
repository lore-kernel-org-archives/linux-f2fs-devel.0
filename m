Return-Path: <SRS0=onZI=YW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9ECA9EC0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:27:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E22A20717;
	Tue, 29 Oct 2019 00:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="VOzjm9sR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lr3LtW1f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Y1gZZMON";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="N549/5ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E22A20717
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yh4iNxc3DIWgOA2eqLghKS9IFPCteQyEn17N/XG/ako=; b=VOzjm9sR7Mpx+STo7FW9Q0JDIq
	7R2cdIm9FtSoO2w+pAtfYt6/Wq9pgHyr9qiO0ST9W0h+q2nr1/iM+npd/VCFblp6wTuIYypWGbAlo
	TITYAmZwR1VmkT2SH8yGBCrGytRvWvq9cjvR0LAX71InEAHoui5CkImKS7rosaMftTjA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iPFMA-0006wB-TG; Tue, 29 Oct 2019 00:27:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hridya@google.com>) id 1iPFMA-0006w4-5p
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Oct 2019 00:27:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EFG/NUMsi6FfdyRZ+1e8lH7DWnn/2sbhoHTkW1LTspQ=; b=lr3LtW1fLG9Rsdth9v3RkQ/dxg
 nsRNUJPhvTue6hv0zBvGM+7n8FP7MyBkCg46kTEOutYcdVUBsAgKujLqhOY7/pOQFwobJYRUWPrB2
 VEodJu+ndcaO11encyf472ek2HMcgtd8q6AWFdJaO7tpWCo2pCarEr8cFxxioG0V+7/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EFG/NUMsi6FfdyRZ+1e8lH7DWnn/2sbhoHTkW1LTspQ=; b=Y1gZZMONbcnpMUN71B+aORD0ih
 XCJ5xAo2ehfDsb/bizn5OLVLUwJ2d0Bum92wew0dpCl8z+otZ1y0YrrufhgonkZsDLGrXvN8WPWSP
 teKQ7YGPBZ8u6BGCzFDq7YM3o1C3R1Wi9auZjkUUAqjkYoyhBGo6DffJ9bECVCJiHa44=;
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iPFM8-004lkS-Of
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Oct 2019 00:27:30 +0000
Received: by mail-ot1-f67.google.com with SMTP id b19so5934225otq.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Oct 2019 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EFG/NUMsi6FfdyRZ+1e8lH7DWnn/2sbhoHTkW1LTspQ=;
 b=N549/5eirfYiMcEkpgmhVSSpEyVRHSOgPEz645xTJulyOKXBFmbS+kttzA1bI4775t
 KEB4cnQ8CSDgEaf3xORF5wcjxQN4e+EJo3f0Vm0GOg/j+Ahj2Dk1sSIozG/tGExY4mmZ
 KhHByJXLiNKUABr8oFs+9R4n4hLJs7TWoSpR0lCSSWO8XFfPKqYjYdevQPekSBIPqxA3
 HvsjCa7jokmArh/ClM6pBzyipGOeaECa9E50bk2n6MCgYC8hn9dVW/OmmX25MFTC7gjG
 xTo47H1OBR74DUU0lbosTDLdnRM84NtxVrWeadlk+AwZH22SaGHJUA/R32VBcK01dqt0
 VAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EFG/NUMsi6FfdyRZ+1e8lH7DWnn/2sbhoHTkW1LTspQ=;
 b=J1HeIaK8NnvxnOU2KYk60q59159+ys5o8llQIDMQZJdIMhAlvvHGc6rQs3EipnVJwk
 7/pe9bLrsnAX6E6qKJsAVdpMmDTs7cKqRe0bklrlZFr/PzYkfF2SCdpzs+1rjTe8i49/
 uyS38wsTz6Tzcq9uRwZ6c0jz/NDC7AeYS7eyAsqV6VS5JqrqLHpVImaQppiSRS/WEB2r
 JJmhrAB/tZ1mzOy52S8llz0sRRWpUqmKi3LaxwHpvUn3siSVRwvARuFc64QJWZwN5eI0
 sT3cOS+0LF9JQ5DxkoSQSSTGmDDMc5+CY3pLglCMScAs3xnk18KGxELJanlqX0tcVcjv
 2j1Q==
X-Gm-Message-State: APjAAAUO5E4mXpa6vll4ZRqs8c9spCqIhohUhn1SOGIW9BwtwPNa5YEG
 gGHYeq3DIqEUAKFCKUJzPrw3QG31ahK9DYgSyEtbSw==
X-Google-Smtp-Source: APXvYqyyMmC6akibUD0ctyx6cZAI+MIQu4fGSJOdVD9ulOLlox6OONUlRS6Dqd0X3Ff0CgmITcC9+WmmkjuDol9LmWE=
X-Received: by 2002:a05:6830:1bea:: with SMTP id
 k10mr11448680otb.190.1572308842618; 
 Mon, 28 Oct 2019 17:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191023214821.107615-1-hridya@google.com>
 <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
 <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
 <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com>
 <20191025182229.GB24183@jaegeuk-macbookpro.roam.corp.google.com>
 <eb08716f-2f56-30bb-d71d-28125b3b0608@huawei.com>
In-Reply-To: <eb08716f-2f56-30bb-d71d-28125b3b0608@huawei.com>
Date: Mon, 28 Oct 2019 17:26:46 -0700
Message-ID: <CA+wgaPMcJWqwiQwt9z0+C5AFMbAB7wSuNeE9wvp3PDOYF_6kew@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1iPFM8-004lkS-Of
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: Add f2fs stats to sysfs
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
From: Hridya Valsaraju via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hridya Valsaraju <hridya@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 Android Kernel Team <kernel-team@android.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 25, 2019 at 6:38 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/10/26 2:22, Jaegeuk Kim wrote:
> > On 10/25, Chao Yu wrote:
> >> On 2019/10/25 11:51, Hridya Valsaraju wrote:
> >>> On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
> >>>>
> >>>> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> >>>>> Currently f2fs stats are only available from /d/f2fs/status. This patch
> >>>>> adds some of the f2fs stats to sysfs so that they are accessible even
> >>>>> when debugfs is not mounted.
> >>>>
> >>>> Why don't we mount debugfs first?
> >>>
> >>> Thank you for taking a look at the patch Chao. We will not be mounting
> >>> debugfs for security reasons.
> >>
> >> Hi, Hridya,
> >>
> >> May I ask is there any use case for those new entries?
> >>
> >> So many sysfs entries exist, if there is real use case, how about backuping
> >> entire /d/f2fs/status entry into /proc/fs/f2fs/<dev>/ directory rather than
> >> adding some of stats as a single entry in sysfs directory?
> >
> > These will be useful to keep a track on f2fs health status by one value
> > per entry, which doesn't require user-land parsing stuff. Of course, Android
> > can exploit them by IdleMaint, rollback feature, and so on.
>
> Alright, I suggest to add a sub-directory for those statistic entries, we can
> manage them more easily isolated from those existed switch entries.

Thank you Chao and Jaegeuk. I will make this change and send out a new version.

Regards,
Hridya

>
> Thanks,
>
> >
> >>
> >> Thanks,
> >>
> >>>
> >>> Regards,
> >>> Hridya
> >>>
> >>>>
> >>>> Thanks,
> >>> .
> >>>
> > .
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
