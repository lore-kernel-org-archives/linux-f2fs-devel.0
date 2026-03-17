Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B25FED9E7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7M7r4ayrsoqPb3FFuh1vT5sTpTyGady3ny+enXXXtU=; b=Okzmq36xjpsbhfN14Le7xep804
	6Y/QzcKqqWGIwCJL1GJ9SLbszbWMBQiL+GKBByZztB/WT814IHuMKdRc1BkXayMm6hwu5C/NE8aex
	cU37tnTQs5scAklQNJvvnchmSUXL8kY2JGZ0ZSUXcSvlewL5t6ytDdoyNYGBW5DdY16k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2WLk-000817-HZ;
	Tue, 17 Mar 2026 15:28:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kth5965@gmail.com>) id 1w2WLi-000811-Ld
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 15:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uyVz1/VY28BNGviPo4SJ7e0WzgpIsIL/HOrakd5K9SA=; b=CphGo60uS8ng4cZ0Ay/YoRGzvk
 nGXTkuls6f0nnNAM4A4iOZAirl4XLe7JFiqc0sk3/To7Yx72017Yj/k0nSs53HPvX6H6noPIBEfIn
 0VWGk3kgx/7oY42A1cqgWbqYTs9VuowbrBSQRaXip+bZwW/Jveu9REiC8llnXbXjxqok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uyVz1/VY28BNGviPo4SJ7e0WzgpIsIL/HOrakd5K9SA=; b=VNdBWBbOoT3oMmrFJzY3tx7G+W
 n1T8kFkgInTNr5/kUpysa+FNx7R7a/XC/SHOjaselsDy0HN13l+iL8aEyRx+PvEc4si0CkjAR+L8W
 Fif2mmPwVKIRcbDyu741reDRbH89gk4tvFKiSgWX0Aa1zsk9DNGlbtCM89hPRqSC+u+0=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w2WLi-0006DO-9S for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 15:28:50 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ab08e6c553so5087175ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Mar 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773761324; x=1774366124; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyVz1/VY28BNGviPo4SJ7e0WzgpIsIL/HOrakd5K9SA=;
 b=hSrP0GDpXbPXNgZZZ9R1dPdOh7ZQZKA1fKdCIBuD/e0gZ+w5gN3PYCNMrxyJvqqiIJ
 nhyux5qhV9gNHyJu40JbNOX0e7VvC88VqcOJoKJ+fYUXXuHT9E1619ciJbQZ6SRSJxEB
 dCPd8R7GaqXy8yvQb20aA6cErLQ68Oh84ZWK/VNhBPOT1VFnPa07w5c+kyb2mDaN1vWr
 UwRPzAOs1JSbH/7HuncKXaRL41CViJ6eq/YpVwY1/WxPKI101RtVwztmQ+qbhn+I1NTC
 JQbBg09ZR0WqWD7iW9q8vFQp9AfTtV0ujwrxib/4Kyl/UKNs3oN1jg9HRoWOQ/11Lnm8
 lOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773761324; x=1774366124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uyVz1/VY28BNGviPo4SJ7e0WzgpIsIL/HOrakd5K9SA=;
 b=gZd2Le0+8eZSPQ2SGPODTRuyEOzYjNH2GDBH42eo7DmEnJoCVbolMKr9oxURWnh6EQ
 a1A3fSyzVa4fY2N5ardsN3xFCNn7bJiVWxQt9vQHJQ0405czAD1m9SjHjgLKnVw0cZ96
 yR4SplPbrgics7l8W3jFHgVk9xbV4XG1YArjkJOpCW0TO7Zaap8zqx0QqcdehNLZsYgr
 xxraait2kqXKbrRDZa7tetqzvI3Bo22kQe1fuvpuf7A/vGytHl4RONwL0bp76/qISJBr
 dwH83Ffifl35RZ0h8oIiauC70FNfpJwYV1GpuklGu+nFgi6Gm6kOf5/aV294KB5t7v5s
 dEDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuvDQOfL1a4XxRMzPxg56QkMlubyMV6Xk/jToF1MR4jgXvRSRJPKQt4SlbBKi6VYTjZfZuHr2hkpgeb4MkwxcB@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz8VKIhuYYUOhYZ7qyz5GrMESoPyeKNn5aukedvT6q/YCu40Tdh
 tvqIUMD1K+TSNVTih3UCy9uBxEHoepn5bH+WFIATKjaXsZmw871yT1DB
X-Gm-Gg: ATEYQzyk15YI01s3FIujOau+usrS7rxXl/qgxSqwOSdBut5orgIR2QAMpwRNneutNKM
 8+mZWdB+e6WJ4HMFmpfQtYVra1xYdYg6/m75ysljGFXkUMD2C9caae/vrE8yoaVeJmyWfE6hI/L
 vs22GiFUBbCryikk/yrzpB0yflELCggxKABdm1sAQ3/WRKlvxyQTv6BaY7CJh4ahtf6lWmJ4RjE
 4aYCa6LRxhJOEGAXIFWwijrIxO+6YlT+xP0Lz9bwiOkFJWhhhmGGtpNrP6SwUc3hYGFWXw4oynj
 aH3hMAuzhPX1nKQp8dP8ROMR/sCQHApWyW8VrHuQyNMSyPgAEQpyTl7IsmOEqgN5kpcM+uZNQ55
 w5XpXd1T5i24Bx2ALmq9UAM3IhgDO6ZxCHmn4iZ93en8g/eFry4imdAy7rjrOkufvMwO+Yw0CoE
 cWPU8mJMLymzIqFmgsRcqCY4iMEDu5SQ==
X-Received: by 2002:a17:903:1503:b0:2b0:5cac:2a7c with SMTP id
 d9443c01a7336-2b05cac3114mr40521775ad.8.1773761324515; 
 Tue, 17 Mar 2026 08:28:44 -0700 (PDT)
Received: from kt5965-NUC8i3BEH.. ([182.217.14.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83b35fsm159789725ad.80.2026.03.17.08.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:28:43 -0700 (PDT)
From: kth5965@gmail.com
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 18 Mar 2026 00:28:38 +0900
Message-ID: <20260317152838.26664-1-kth5965@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9df7bc57-f0e1-4c7b-9ce1-0017eab62c2a@kernel.org>
References: <9df7bc57-f0e1-4c7b-9ce1-0017eab62c2a@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w2WLi-0006DO-9S
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: evict: truncate page cache before
 clear_inode
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
Cc: linux-kernel@vger.kernel.org,
 syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

I checked the repro again based on your comment and added some debug
logs around the related paths.

What I saw was roughly as follows.

There was already an abnormal inline state in the read path:
inline flag: set
data_exist: clear
blocks: present

This case was not rejected by sanity_check_inode(). From what I saw,
the inline sanity check does an early return when inode_has_blocks()
is true, so I think this case was skipped there. I think this may also
explain why there was no sanity warning in the log.

After that, in the eviction path, i_size was already reduced to 0, but
f2fs_truncate() still entered the inline conversion path, and
f2fs_convert_inline_inode() created folio 0 in the page cache first.

Then f2fs_convert_inline_folio() handled the empty inline case as
success because of !f2fs_exist_data(inode), and the created folio 0
remained in the page cache. Because of this, nrpages stayed 1 right
before clear_inode().

From this, I think there may be two possible directions for fixing
this:

1. prevent folio 0 from being created at all in the empty inline case,
   or delay folio creation until it is actually needed
2. detect or guard this abnormal inline state earlier, in sanity check
   or before that stage

At this point, both directions seem possible to me. I wanted to ask
which direction you think would be more appropriate.

If there is anything else I should check, please let me know.

Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
