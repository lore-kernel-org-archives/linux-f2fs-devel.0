Return-Path: <SRS0=xRoo=FA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48931C64E75
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Nov 2020 06:21:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DC120B80
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Nov 2020 06:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="INpSPBCd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GbMdTCrZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bFDpg/Z9";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="ezaCvQHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DC120B80
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LG0xUSpBlKOoLrWuDOAlkQlQ18PZHhpHkfAoGRDcItg=; b=INpSPBCdQjJGYjie+8DRkH0N3h
	YeON9ILn5p21CWHgEo1Uy52MZosWYf9enzUg21rsbpqbecLdCgtFyDK0Cu/pIqya/1rBubt4rn1xS
	S0r18ln31VnaoTw3IxuKfnPD+dWc63HhEERzklY1W1sQ2DOwI/Zxy5Xvja0E23qr+DgY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kiAeR-00045f-6Q; Thu, 26 Nov 2020 06:21:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1kiAeP-00045G-RC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Nov 2020 06:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q2R4BbQCpkO9YBouwmBRKUyTxHnROMBCPNNTzvr+bTs=; b=GbMdTCrZrq81FyxxnBsAzDpouo
 nNDuWYoMDSsycThf/f7j7sv/2ajFRyfkv3iwJ+yV/DAyzFTi+mIh/6IgzI1N6z0DVUu4GwY5yjhD9
 ojY8ilrbJ4KXhu1eFGPd8kIiqdK26WA4fiInBw0cTxsa+grZcaAwA84x3/3jyfKqVdSA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q2R4BbQCpkO9YBouwmBRKUyTxHnROMBCPNNTzvr+bTs=; b=bFDpg/Z9dCUFkWr6ecb7m8AzOn
 6hjNy9yY/4uwnt4Qdnl1F6zUCS9OhZ/8Qcrc+EExW4+Nz68kpPCu+rMmvnOgNwNdfIeEFPMs7U6Yq
 C1ZnvwTvklitE9BnVjbaezcHPZmEUMx1qst2wgN6Ei0cobudu8ya30xKDs9J+eBqKk10=;
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kiAeL-00Gk80-5h
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Nov 2020 06:21:05 +0000
Received: by mail-oi1-f195.google.com with SMTP id w15so1108993oie.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2020 22:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q2R4BbQCpkO9YBouwmBRKUyTxHnROMBCPNNTzvr+bTs=;
 b=ezaCvQHNP4rXVlX6xgXScBgYsPbPPYeNewlmWmduFOZEwCAQiePxmYmVXxRNWIAKBj
 npE5+8DtXXxl5lIDZZS0EJDFMin+cuNhqnF9GVWXdwt95ToczUH17XgI/N/f5RDdgVTk
 K20LAvN4Q8KwIAWKWxz7lhuudgoUDjDQNgOQ9wCJS5pv4UlJ8k6N+hip7il4Tw3qlp8b
 FAv350pYhHk1L7GaNKcFbR2Ti54nHn0eqb/zzb9ABRY2bdSGl5MHh8QN5HMKW/YmAQsN
 F/W7hV8uygULP8RYNfy2hBUXjRLteBmuEIR1j5uixtkiJBAM3lzJbujbvujPp0OydxG5
 21dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q2R4BbQCpkO9YBouwmBRKUyTxHnROMBCPNNTzvr+bTs=;
 b=Lz+6denPVsViuWPfdxDHkRMgX+D7mI+yDfqpDeo7ARixwORxzpSlesJt1KfCdzf+K/
 AQbAHkfNnmk0k8bhRlTTurgd8HSfABzfH4ROKQt2NtD+gAsT+p4DwLVvZvhfgLA4Ri29
 c2yutVzjvqeR5hGg7i+Ddn0YuE4kq756HHq+ILnkOeIu92q5kGc1tgRPsumncFMd/fPa
 of4ph8Vc1lPzp2PZ3jn6azTkfmnSAJNheal2OlmFrcEWsQCyum2gqqrRu7hxiEy53EBH
 QjWc1E/aMWnLLuLvrlIWZrAYWKwR0SWUrL4F7woP22JMwO6VbMkLj0Y/o1M/fvkWiTbK
 A5uQ==
X-Gm-Message-State: AOAM532Vx/cCUwu8nsWbTE1YyFFTezamzoGgBf3YpBWde3Kr+eOfK+dY
 o6hvNcxnOTCU+c3SA0WZmPWBoRzFzNINP1+VhvwaLQ==
X-Google-Smtp-Source: ABdhPJyKkUGNp5ptVTQH/y3fdaO8WHD96bnV/Avp1SQ7JFU5f6ksIk+NGtCwlONjNfoJPAp1skv4dkqV7brJ0Qje4qs=
X-Received: by 2002:a05:6808:8c8:: with SMTP id
 k8mr1163796oij.84.1606371648249; 
 Wed, 25 Nov 2020 22:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20201119060904.463807-1-drosen@google.com>
 <20201119060904.463807-3-drosen@google.com>
 <20201122051218.GA2717478@xiangao.remote.csb>
 <X7w9AO0x8vG85JQU@sol.localdomain> <877dqbpdye.fsf@collabora.com>
In-Reply-To: <877dqbpdye.fsf@collabora.com>
Date: Wed, 25 Nov 2020 22:20:37 -0800
Message-ID: <CA+PiJmQ8-Qxu7yNWBvRLAeGa31PT5=hsYCcoW9QKsKnJQXqnMQ@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Headers-End: 1kiAeL-00Gk80-5h
Subject: Re: [f2fs-dev] [PATCH v4 2/3] fscrypt: Have filesystems handle
 their d_ops
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Gao Xiang <hsiangkao@redhat.com>, linux-ext4@vger.kernel.org,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

>
> This change has the side-effect of removing the capability of the root
> directory from being case-insensitive.  It is not a backward
> incompatible change because there is no way to make the root directory
> CI at the moment (it is never empty). But this restriction seems
> artificial. Is there a real reason to prevent the root inode from being
> case-insensitive?

> I don't have a use case where I need a root directory to be CI.  In
> fact, when I first implemented CI, I did want to block the root directory
> from being made CI, just to prevent people from doing "chattr +F /" and
> complaining afterwards when /usr/lib breaks.
>
> My concern with the curent patch was whether this side-effect was
> considered, but I'm happy with either semantics.
>
> --
> Gabriel Krisman Bertazi

That's just from the lost+found directory right? If you remove it you
can still change it, and then add the lost+found directory back. Isn't
that how it works currently? I definitely didn't intend to change any
behavior around non-encrypted casefolding there.

I should look at what fsck does if you do that and have a LoSt+fOuNd folder...


-Daniel Rosenberg


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
