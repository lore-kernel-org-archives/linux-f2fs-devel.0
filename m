Return-Path: <SRS0=th+A=VO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7AC76186
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:42:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC4B206C2;
	Wed, 17 Jul 2019 03:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="ZVuap4k0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lbHav4Pt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="U/K3O3F+";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="MEXCEEEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC4B206C2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+sv/hyWxNTVLeMaF/WkST3thWla1hDvc0Nv1mD7FHbg=; b=ZVuap4k0k0SYZgSQzggj0glM+W
	eK65nOnGk/PWV2/FCDFNsEGVV5gW+EnkDS8lMQsHtxXlaIAMiz4MXSBCovVs/ZyVLEyBfQMTgM2L+
	FctxBEQbr/B0xWmwbBh69XcS1yLW16C39ChYL6x+9W8NqsRSEXYbkh4oC6Z7T1HF2/jU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hnapy-0006pw-3s; Wed, 17 Jul 2019 03:42:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3m5IuXQYKAGoLZWaMVOWWOTM.KWU@flex--drosen.bounces.google.com>)
 id 1hnapw-0006pf-BZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jul 2019 03:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=; b=lbHav4Pt8WYW5w7JA2KNdQLxrr
 OIibsv0uhuiJb4wxUibcmOfAwXb3CUCb205eaKRaa86NWKtJg3LBwzNRsY4TqD02r1YCh+lOf4w8k
 lCBsNVH17ihlYWXOWu93fuhOBnQPE3tfa/kN0b7bTPvX8dWH2rRS/5t2EG5J4h0LdQqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=; b=U
 /K3O3F+ufevRKY8+ZMrGVNzyk72/mC71TRMday9P3KqnNvmRgFHdDGqEDxLQXfR9T6+Fa2gLCroU7
 KAICWvkYsaJsfhFDVzLhBUFEXlWL8Kz7Zg+Tv3NeN3V6qO5mpc0sxd7vz/MkZhF9QKUa3ixfgNAW3
 JIWY+lVx730ruJ+E=;
Received: from mail-vk1-f202.google.com ([209.85.221.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hnapr-004cBH-I0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jul 2019 03:42:36 +0000
Received: by mail-vk1-f202.google.com with SMTP id r4so10673938vkr.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jul 2019 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=;
 b=MEXCEEEPk/KuaWu/bxTbcr5Sv+ljjVJ5OJVxaekxPizc/h96zVyZZfexEYA9SVYpCV
 mjNK6v82DvgDgHKwdyC4kOKNH2VJ/VJDJ+Y8EGV/S4OPONugktXp7uenWF6BpIWIsCSn
 gk3QV/pTD0f1Ot1c4jFr0WyU7r3ZDFKJwWEsD3c0beg4TGWOT/qN2B8YjkmGYp7ZfOmq
 VZNWdX98/zP1yYpmKExnU7XInexP5ArSxTe3Q8MMV4Xbp5bv4dbT2Sr0GFZ3Fhvphn9r
 fMeA8QrxkD9RtLezfb49TUuBcKK3TcBeIUT8g6TVdU4YZSjYdoI3P20T9kvbW+psLYnL
 0yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=;
 b=e75XSE4r8wSqBONl1I94FTqgYNEn23ujBqcr8rcEPAhXU+24MKnpa5e7rVD+fzhHfC
 ctUutPm0e0wZN83Hp+el1zsFvHcEJSEWayLD5iIZvANxCrLB7cSnM9k/3zBAgHZjLqdw
 yB/MQtNsZ406GLCibno65VzbJe4PIMIw+m0HODfybbcqQ6ONt3UEgN02h2I+zgROBdJE
 iTFJ15dYW3T4TTr4Vf2uwzZigbLWoNX2fjOWVF5Vf/1MmA4/yf81cenvGhgyt+b0/IGS
 v5OKKv/d1u3m0GhXQY9dlNl1Ixq06bhWNZqlvmN2dOTRSQlMr/VkpY+D/tB7AUew1f8I
 ORJw==
X-Gm-Message-State: APjAAAUtCVrVuDMYPl4qQL4FEVO+sZzK3406rjAopz0HoN3itDwiW33C
 2c4qGeSBiDHYPGS/XmlR4bZl/VLe9Cs=
X-Google-Smtp-Source: APXvYqx7EouYm/UBart6k3P8SNvF4Tt8Vrp1xqHYavJUzIKt18aw8pMHkXoYXAv17A98VxuiVijQcGClnME=
X-Received: by 2002:a65:55c7:: with SMTP id k7mr6163284pgs.305.1563333275476; 
 Tue, 16 Jul 2019 20:14:35 -0700 (PDT)
Date: Tue, 16 Jul 2019 20:14:06 -0700
Message-Id: <20190717031408.114104-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1hnapr-004cBH-I0
Subject: [f2fs-dev] [PATCH v2 0/2] Casefolding in F2FS
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
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

These patches are largely based on the casefolding patches for ext4
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (2):
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 fs/f2fs/dir.c           | 133 ++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |  24 ++++++--
 fs/f2fs/file.c          |  10 ++-
 fs/f2fs/hash.c          |  34 +++++++++-
 fs/f2fs/inline.c        |   6 +-
 fs/f2fs/inode.c         |   4 +-
 fs/f2fs/namei.c         |  21 +++++++
 fs/f2fs/super.c         |  86 ++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |   9 ++-
 9 files changed, 303 insertions(+), 24 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
