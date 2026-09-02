Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BC5C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W3rxge/7bLcOd9e4mBGWXg5OlyhBl+rYxayKCk3C4RU=; b=diMiCK1QlpHnkleP4QCDpHc4i7
	TLLX43/2KN1oJAwi2O3YJQ1xsCVj12nq2qKwp81uo6NdMs5gZ/AtaciF2eQQRecWSAa0khkfNMEnE
	TKyz35z6uJFalDPUA4LmGg2x0lNEJiUCc6E5Dqxre6bxZF7kvg6U3T5bWs9qSDkocVnc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1jby-0000Yz-6Y;
	Wed, 02 Sep 2026 11:58:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1jbN-0000Wa-UC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZVF3OnSwA/qMIPyBbfYfBBIkjgQyRTS9OHeMu2tZqw=; b=ABK/vkOyZUjLduXsFjhu6KUr7a
 2p9lE5AoqGREKC1jY9G6M7Au8niPm9nczOMugstBkHln5CCHFhau01OmIgZmozMoVv80wq1//lHSU
 emEsn5U11YCE+YuUCcoaWq0zL3RwCmngo9ycIrYNV4KxMfofQGNQq4KU4Y2RWGIx/Pgo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vZVF3OnSwA/qMIPyBbfYfBBIkjgQyRTS9OHeMu2tZqw=; b=bDtSCV1yuAVpu2LGBI2bXSmU3J
 NByVv2g2iABk956AFhlYMeJ5MFL4YXecZac8yfiSM+pNdCqHZ+5HtYum7sZuhIOWBjyFoIjxNS5p2
 oudFAt/QPrpic+M2rtw6ErA/pYkbj7sFc3d7OLpIhP6WZcLJwuNMufEp7ehQjkgzQvDI=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1jbN-0002ko-6P for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:58:02 +0000
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1660461a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788350275; x=1788955075; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vZVF3OnSwA/qMIPyBbfYfBBIkjgQyRTS9OHeMu2tZqw=;
 b=sIDuEag1SA+ZNXkuP+4cFY4QL8ByJ5VRIkI8SvUZ9t9bH0S+aZiMO+qZzWGDxE3n9g
 Rzv2HsDCH5iVC9BbzzgCv1u28WtmFtVpMsM8uEZY9F1IRiNy3SpGFc27R8/U1V90vE3Q
 kfWSlRLfC6vTgo0O9bwmC8aDKXpj2UNkOQfCBSoTmUPGUry8DK6U85Y5OIW/oIE56Kz7
 uYy/77ef3U0mpGT4/boBlATnfNtK7JDEBwVQ/AgLbZzdD9JPpRYTfuuNbE2GTMACSd0A
 0ID19cikRRnPRpTgLJZCvASezfsUO4W3XP9BUqyWWk054VXKigqeyBMo6Wyjz9zH8u5g
 Q0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350275; x=1788955075;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vZVF3OnSwA/qMIPyBbfYfBBIkjgQyRTS9OHeMu2tZqw=;
 b=OZ+VoQtGmETpUqwEblN03oPkR/dgaJusLPe7Vg+2Wwq+HjrtJcYRELpDPYi2fShKQx
 JPE2JZGuLbkjZGmZ1Ujj5r+lLjnDvUPCdvgNdfxIKz6SnzBI2K7Vpj33f3j/ishKgorz
 mi5dlK+scmvHJdPSwb7hO3xFnYdaxGpNpdbeYHi5tbMk0/QiE5+Kdrz0uEXVp/z428O+
 O9avpSaf/dgLTNq9UlrCcC+CS47GbuZYcb+m3R5nSoWXcAbbDiWphOk1iGMFkPM3+sMi
 pR6xXW0+psf2fla50PLiZBrro9ghw5PTCWDoD6etJMXjK60WR7XCYxI7NA4vklQWKMt3
 VUTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYTH48oFkCXnEH3/gcPxLpzJcRt89gb1aeR3DvGcQPhyC5bOmWVMy8abm1jr6h3hTyGfxh9mWXYR+Gmr5nw+B2@lists.sourceforge.net
X-Gm-Message-State: AFuF++kwgYTlHp0nHdvZxE8RZXUV7hbTb90/v6gUlodd9Yuy9oZ23MbV
 0FO/paq5h2makmTZMDjSmGNMmuoRdCRP7yxaJvnxPv9uiQLcN9AMtsl/
X-Gm-Gg: AYBFou1iVlQKc0rh8pMlp6TBXp4QNNisfCMolDrM8TXSVqQ2b1wvBZ4WrR/A7Y3giPR
 DtHnZhQcdZ0Qu+SDQtUv7XGwfIdGLfyREA/03ZzEx1MrZ4PdPvWI95LwqKG/x/t1r9NIcoGytK9
 or8/cVaOfYnmbPekbKQu0ldjhPTtz2dz8QlC0pYrsENc3TbImDt6b/n0WXDdSiUJN3UIbrd8YXh
 ELuEGK2QfpevNjV3HElL2KxcfPTM9Viu1p9JkpE43jsiBidFvgbAWPJ+njNnhICHEzhtbzFqrZu
 Pd8Teyyh0WBGkDqVZnVwkENrWSipToTe8zpgbsZA1JZzCdUueXr+WM7q009wQaU5I0B2SI/vWSY
 lOfZ9q99WImdTO+vzplX8iRLVr+4n09FKN//EhqJTSUjBzVL44SKQiW8EQdcXndNjj/OLM9PAjE
 paiRKF5c0DPRL6JH//X9DC/Ja4d47cmDu88krJgHSdqrwyy8J2c7521Tg9VdfjgwS7Bpn2aw5VK
 JH2aeOpyv/vFHw3YzMpe6li
X-Received: by 2002:a17:90b:5201:b0:398:ba46:1d9f with SMTP id
 98e67ed59e1d1-39af655b35dmr1951709a91.13.1788350275447; 
 Wed, 02 Sep 2026 04:57:55 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae0f28b19sm5919574a91.6.2026.09.02.04.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:57:54 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Wed,  2 Sep 2026 19:57:49 +0800
Message-ID: <20260902115749.692330-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831092227.739737-5-chao@kernel.org>
References: <20260831092227.739737-1-chao@kernel.org>
 <20260831092227.739737-5-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x1jbN-0002ko-6P
Subject: Re: [f2fs-dev] [PATCH v5 04/12] f2fs: cache: introduce writeback
 thread
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> if (flags & SB_RDONLY) {
> 	if (sbi->cache_thread.cache_wb_task) {
> 		f2fs_stop_cache_wb_thread(sbi);
> 		need_restart_wb = true;
> 	}
> }

and later:

> err = f2fs_sync_fs(sb, 1);
> if (err)
> 	goto restore_gc;

The writeback rollback begins at:

> restore_wb:

and the GC rollback begins later at:

> restore_gc:

The common option rollback then contains:

> restore_opts:
> 	sbi->mount_opt = org_mount_opt;
> 	sb->s_flags = old_sb_flags;

The RW-to-RO path stops `cache_wb_task` and sets `need_restart_wb`, but
the sync error jumps directly to `restore_gc`.  Since `restore_wb` precedes
`restore_gc`, this edge does not execute the writeback-thread rollback before
the old mount options and flags are restored.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
