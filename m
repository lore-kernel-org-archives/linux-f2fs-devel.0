Return-Path: <SRS0=onZI=YW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3886CA9EAE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:54:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC272086A;
	Tue, 29 Oct 2019 17:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="j04lSVv1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ciNJ1YaT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="FgzPmRcT";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="cIKrfG2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC272086A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=biZ6RDb8tRZ5K2viZxh1/IaOe6PAx55tiIgG5S/sDjM=; b=j04lSVv1ObSSuKD2PoA5RD0uxN
	gkmCwjHM0lWry9x4Q1+FOzEfIBdvMoSQE36Vns113wRPJsA1+MCe6G83hoR0n5iFhnEMYGgJ8boyr
	vRF5cO/E14WhuEd/Ek+zqIFWYU79bB10v3sQkbWIcYTsybj3vmCURyiTejcqXVRdMy9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iPVhM-0007XW-UA; Tue, 29 Oct 2019 17:54:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <paulcrowley@google.com>) id 1iPVhM-0007XP-CL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Oct 2019 17:54:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R35NzCe37FoRr+JmWaRxXNrs+ANr5l1yDPp+eQUm8vU=; b=ciNJ1YaTtUeGGZ7Ut2vCUZL6Qc
 L0G5C4Y3MhFfGwz6CFY9ccd6dd/gWY7ujikWOr7urjYPFy6oNj+cEzaxQsUzVZ0TomoDgwI7cCYXC
 wiB95HJ+lydYvFixxJwXQdBr5lbPsJvrW8YVE/xzj+1pxHxbGVnlIc1tGtV1apOmpmzs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R35NzCe37FoRr+JmWaRxXNrs+ANr5l1yDPp+eQUm8vU=; b=FgzPmRcTPD0WcnG3hjQKw7EWbd
 5mCsfwu7J5LX5r8NLC+4y/i4kJK8LgenyT9cmiLVZypw2Csv3ZwYy+70Im1CJTxQitjy/8q2qwHlS
 Nwwgmix1DNvH2dJdIGWIcNAvSqFEQkoqH3ctSH/gSk45KUnRNEkyohED8sHbAn0TxYTQ=;
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iPVhL-008w3p-2C
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Oct 2019 17:54:28 +0000
Received: by mail-lj1-f196.google.com with SMTP id s4so15374136ljj.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Oct 2019 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R35NzCe37FoRr+JmWaRxXNrs+ANr5l1yDPp+eQUm8vU=;
 b=cIKrfG2BcBsU9hYXIpQdSwopgElTE4RautsHm9ZOuGHXTi69dKNkh17wSQH/L4zosA
 DI1JpADSu0a3R25/VXr5Iz0OjSuf3z6tAsWgiVO+H5ZF/9VP2xOxAKxjdhdoLpjleNL1
 GGQBMKSg8yP8LIjunquGxXVF8tAxYNJNCdEfsXnbnr55B8bLQDyruSeqzDYclYPGSbAm
 HJjhrG4J94CdXOlytO9LgDMPwdYA+nprQ2rf2m4rCZfPfrNaJYmSZ90g3N59yzI3oBGl
 vPR4bxKynazkligieSoyOTOws2e6shukr1fmmOZGMEygc+XcvpYmK61rppkwFwgRbTjB
 zPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R35NzCe37FoRr+JmWaRxXNrs+ANr5l1yDPp+eQUm8vU=;
 b=UNp2iW75snZurZ5p61RbISLq5lTzvMwtte3YTE0RNo2eKdm3IDDZ93McbvIVy6UoXv
 HkqL38rYXfNFP9ljyfz5D9EXTVjFXOMOeBi46/PwXhd9WUIU/K1N8kGp6gEhrkGPVmbF
 sc8lan+18np6sUfomEjzPoXZcqaECp0DBURHBG430OM1huRf2LKBIJMVopmKYRbQs6wC
 mxieREgsT8PyqsoYVxYDx2NpecPo4UsjB16tGJCau55hd+Ovx2KQDFbuHhqdbNmuYaxq
 R+tfFph8O8RdyWJF60r3RaUBXBc7sFLrdZLHgt02Y06nEXwOY4uxTLMtArlNH4YwcmNf
 L/cg==
X-Gm-Message-State: APjAAAVOM0VdeX48tpMUL3YV3UgDDYAreHD8hvYQaN1hNgiyADSM2fnv
 CX90ruIaA0Sep4r+zNu7QclbWIG99FpZh8IH1Z/BxA==
X-Google-Smtp-Source: APXvYqwNTLBO6ek7haLq57qS7qFh4V78zjcOU4/j+rzIkHP000hEzkPtfT9hnV441B6ZiktsLU57y15HuzMTPyrd4yw=
X-Received: by 2002:a2e:96c9:: with SMTP id d9mr3387439ljj.247.1572371282017; 
 Tue, 29 Oct 2019 10:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-2-ebiggers@kernel.org>
In-Reply-To: <20191024215438.138489-2-ebiggers@kernel.org>
Date: Tue, 29 Oct 2019 10:47:50 -0700
Message-ID: <CA+_SqcCefZRWL2xHRwFABupXyBdq9=jgBK_9gy-_4o-yFXG+Tg@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1iPVhL-008w3p-2C
Subject: Re: [f2fs-dev] [PATCH v2 1/3] fscrypt: add support for
 IV_INO_LBLK_64 policies
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
From: Paul Crowley via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Paul Crowley <paulcrowley@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Satya Tangirala <satyat@google.com>, Paul Lawrence <paullawrence@google.com>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 24 Oct 2019 at 14:57, Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst | 63 +++++++++++++++++----------
>  fs/crypto/crypto.c                    | 10 ++++-
>  fs/crypto/fscrypt_private.h           | 16 +++++--
>  fs/crypto/keyring.c                   |  6 ++-
>  fs/crypto/keysetup.c                  | 45 ++++++++++++++-----
>  fs/crypto/policy.c                    | 41 ++++++++++++++++-
>  include/linux/fscrypt.h               |  3 ++
>  include/uapi/linux/fscrypt.h          |  3 +-
>  8 files changed, 146 insertions(+), 41 deletions(-)

I don't understand all of this, but the crypto-relevant part looks good to me.

Reviewed-By: Paul Crowley <paulcrowley@google.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
