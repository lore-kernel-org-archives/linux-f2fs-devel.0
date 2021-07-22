Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDDC63793
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 06:39:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C54E610F7;
	Thu, 22 Jul 2021 06:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C54E610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6SMb-0003oI-D8; Thu, 22 Jul 2021 06:39:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <daeho43@gmail.com>) id 1m6SMa-0003oB-2b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 06:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4B86nDMuJsoY5qaVZWGr+i+bgI9zMDCAz1H/UIdhBz8=; b=lBcjcVFtlQyVQfJpmVqygrXkNX
 KRwH3hCYjlNiwSTqxucfwowk/wKU4Mbpydbk4LQoHhtoweH8anmdiCemYeD+kM6dXGtwLTBAWjjLg
 DoX/XhndQcbMjC2XRyWa0R1DjRk/mUuV7iVo21IFDK19gA0bTkvldHYW9QLx897da0NA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4B86nDMuJsoY5qaVZWGr+i+bgI9zMDCAz1H/UIdhBz8=; b=mIHMFf4dG+igZYi4Au+mwBcr3d
 4yHpL9HI0Yp4U9lyHgM2F2CyQeAc/x6SJLRKbZvvVTl69xgM8x6pdVIW85JLJGJzCMIT2rSma28Nw
 9bjRhFYZb6EQUcLLweMGW9Byd3mwYloyf3IJBl8jN+U3tRk2/DdnEeE+kvlnT3SPnorE=;
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1m6SMY-00GVNQ-Cm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 06:39:20 +0000
Received: by mail-lf1-f48.google.com with SMTP id m16so6832046lfg.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Jul 2021 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4B86nDMuJsoY5qaVZWGr+i+bgI9zMDCAz1H/UIdhBz8=;
 b=q+O9W4orIuaeNsabKDYJdenqrODw+azr8aXxE8WE2t7KCGz3LPADfZOo2iv+qZajZU
 3mTs4JhFZ9yvVkQfM5nJvuiuU5YrKEz0hBGhJilM3VJ1reXrDMyUXMNr6AinrMdENuGv
 spbj/Ata35GquWd4NMa3obOowGEMEtk403fiSKifQmdKTdiq4stKfLauUc8NleTNuXby
 TB3nlZ7v25wpDUlHM681a/X7YzSGIa8rfBTppXyBNTa/d8lpN8DUop4X3iq6KUM6oUIY
 zZu0VBxYlpQwIPsNblp1PleNS024h8kfY6Bgm/kDXY6OxiD/jJX/WGWKy7Fnyd+nMOZI
 oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4B86nDMuJsoY5qaVZWGr+i+bgI9zMDCAz1H/UIdhBz8=;
 b=k9VDInHKg0m42PAzvegNnAAaOQ3FlfMfJm3zqgIR63W2Q5vZyWkSXKgUxjf0OdgRxw
 jWdIWrQfl0C1aidHq4zkjaPjzpf+Qv93Me1OPPt2KHysJ4QGHqvm1Jj0v3Raopn6mFL2
 mBp/k/HVh8K13XioTrYmUYmNhk27q5xgsgbAzYeXTodmWcmyG4b0FT0/F+Ii5F6UjTvO
 YB8kKz4cfDXCZrENz9YZ+iKVOSzYqMxb7nKY68SdRlyFekyIPJVUU/2eihFQSFB03AbD
 E6AHD+ANz/VhI63IeRva2CDSIuKDqtkyInhAmcvCFrGYUiUWEcTMzwqoYqYM102NHvSp
 SMRg==
X-Gm-Message-State: AOAM530xOHyHeTelQ4rxGlDlEr29vwTaWW5NJwwD+m4FzIMVr1GBE+Q9
 Gps2P3G+QO8Te19FYqjCySA/fJnWX7DBHG+kZ7Q=
X-Google-Smtp-Source: ABdhPJyaimF+6x0uFzkHCnnoPurYpyM0AuYABbk6VtsF1U5CXoVeBVq77XwfAVla3StRIrVa5nsdcxuX+nAJ9O7LfPI=
X-Received: by 2002:a19:c3d6:: with SMTP id
 t205mr27695615lff.622.1626935951887; 
 Wed, 21 Jul 2021 23:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com>
 <YPkPLrBszwr1aiBe@infradead.org>
In-Reply-To: <YPkPLrBszwr1aiBe@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 21 Jul 2021 23:39:00 -0700
Message-ID: <CACOAw_yvmK3hPA_Be=dR5MQapV2uu98coEnJhLZO3bt7Ef3Pcg@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1m6SMY-00GVNQ-Cm
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Good point. I already made my second version of this.
We could revisit later to make it simple.

Thank you,

On Wed, Jul 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Btw, any chane you could switch f2fs to use iomap_fiemap instead of
> the handrolled version?  Especially with the work from Eric to add
> iomap based direct I/O this should be much simpler now.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
