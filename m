Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCBEC56207
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RClvYaztE3ceiZo7+pj/KTLsF9nRY1Fgd0GdeuHnRcc=; b=SxUkb4WJl+CufHJfrETwLkIfTG
	x25NFuXtr/ZyKR09rS8WBXO/f3TyhcPP3JmAH87KyUWkeWT3hyGu/iz/MfGKhxClIkKKXFptUQd43
	goHN+TqzVvkpmux0fkcoaTrPxmKPnI5thJdvvvXGXIYwCWXVIUYfy3uIAQrZ6d7ZRrP0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrzhS-0008KA-4h;
	Thu, 06 Aug 2026 15:08:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wrzhR-0008Jw-2O
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YSUBYiVBz8Xt0AExQbwuKLxCVKlnBqJ8rU1oM9FVNvA=; b=IynBdkkJIVDicpUsB6BrH8IwAn
 oObhT0Uz7nHayutiAl1/Cz3radWgrZ28yKL5xNvkLub3BcdkuP5HZPwdTffCk2ea9L+jzAkvkzx5P
 htPufmW+FAg9OAXQHXd1rJ/HCdvOGUTMaXzlKeNIlI1H1LN28K58YBdoLd1OlCK/atOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YSUBYiVBz8Xt0AExQbwuKLxCVKlnBqJ8rU1oM9FVNvA=; b=l
 wFKzFs/WscMQw6SdykW+UhIJidz2TRtYsFR8942vNmj46T9rqw5xEP2BLHh3Kz51TvX7V4O7dkN49
 kl/9MjBBf2/8DIuJQlm8l9CG70xE7OSbROE4VCFwQI1PQdAS3U7wU4MaacCN28tvQmwSA01Jy+wjz
 W7Wi0RCimPd4oC7w=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrzhU-000295-8E for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:08:01 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so3282837b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786028875; x=1786633675; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YSUBYiVBz8Xt0AExQbwuKLxCVKlnBqJ8rU1oM9FVNvA=;
 b=qBEif/sHGbr/d1uP8L+1JxsGDaB0jOjgCYBsLdSSImYgXcv82m55toeoZGGWEEr807
 mJr69VQAwc5yvMNJbTAT6DLmmX29uMTXogncy2QU1/l51XkfvJgJX3wJLZaArxs3mYhK
 Wra4+Jv7sESIwnuHVzpqx7nd8bkdRxaSEowS9Lj56iPf3Fw7/rrAuBIzkuxnUshUQdy9
 9y05WwSkdOr0gHFU0rQRw4XyIMLs5BbAH9qG/Gd6uw0whC1LLIy+hlXCwzJMCbS320wi
 uTD2q4TKkKl2v7qEsKRBL0NHY5iwTebmW46qcUF+7r+ifHqK2IEjcSDv+Jc4eaFprvdz
 Uv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786028875; x=1786633675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YSUBYiVBz8Xt0AExQbwuKLxCVKlnBqJ8rU1oM9FVNvA=;
 b=YipYTEgxgeNaNEv6szH+Aq3DYovSQFhHiGMeMAnXwhxcdj0JA44ZBWeBB9UywYtdsw
 Js4r0Ov8sAdzSIH3SbJHrhie2CAJa2TQlK/N/bOaujUgBdQCmEWL610uT5pF2F3ai4aX
 MGTYUbcq3/iGwQ8pFaiJMhfCLLXJ5Ih5+gZjyP6wqYGFfXHDFmaCxvPnO+Dja1BGTZiP
 79alA2I7husV2lK1lqTFPnvQQ0K0Xd9TMrsoBwMMY4a3zzoES8vf41409/Tj7WEtb/kY
 3r0OUGjxxE1ElfowBJPz+IkGgzHmWlLUsbhk7eRLem1tLxi2lcC1RWCCHKOC46mfoSJy
 vSzg==
X-Gm-Message-State: AOJu0YwyUFhozZznCbS6HXsgH7fYdp7QtD2QGyk2YXlYQ4pPfBhZo9Yj
 1pBi/b2qLTZxAgbpSKZaEmwvcBjhwGFiN4VAMAzQsle7uT9jNnFlcMpE
X-Gm-Gg: AR+sD10gbINShZPO8TfOgPMh1qAf9X1oGBIgVNW4v2d8UBCPDGXH3U/ZKEfE7n7JHd9
 Vq5pm/s74PNUVnjYlFop7j3DCP7nE611T2PGUiRe5+1wBwZ9xwPrMqNMgI0a5SoZFOu9rF4GfTl
 EHTbT12jKuvWpoEleKrJuw3N6ttz0T3fkF0NbUGCDoiuZYCo6RsB4EDf/4tZy/mHbEs9uhqG2xW
 QFfGdQsobBhkckjnzre0oET9leEFK02PHAxSpAF5iUQ2KDuKNscs6GXp9GKIILjxTeZk8cvzPgW
 oWApYidYX0LDNWSFt1NAWEvug8soJo5Mnh6SBFxyKnh/WSCG6gObL36Xwgvf8OS4L0WlsWJW8TZ
 66kZAYb7I01bIZinaV/Vp5lIt0X0a7zyliS55OEEWpHxMPRdkWFlVJC+1LDWRnfarKGSzoEUrin
 TXMSJAgXcQholBa3AEVZOduGhjuEhtdUBDBsQ2oNZGiGxWb71kBsy7AUpXmKsr1WThu6kBxXz5m
 AiWMeC4Sll1h6VWblJdGG/Z
X-Received: by 2002:a05:6a00:4f95:b0:848:44ae:47c4 with SMTP id
 d2e1a72fcca58-84f2dfea210mr17578916b3a.20.1786028874875; 
 Thu, 06 Aug 2026 08:07:54 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45bc9c6bsm1586448b3a.56.2026.08.06.08.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 08:07:54 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  6 Aug 2026 23:07:45 +0800
Message-ID: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wrzhU-000295-8E
Subject: [f2fs-dev] [RFC PATCH 0/2] f2fs: support uncached buffered I/O
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This RFC series enables buffered RWF_DONTCACHE on F2FS.

The first patch keeps dropbehind folios in dropbehind-only write bios and
defers their completion to task context when completion happens outside
in_task().

The second patch then exposes FOP_DONTCACHE and propagates
IOCB_DONTCACHE to write_begin folio allocation so buffered
RWF_DONTCACHE can reach the F2FS write path.

The split keeps the write-side semantics in place before enabling the
user-visible API.

Wenjie Qi (2):
  f2fs: keep dropbehind write bios task-context safe
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 63 +++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/file.c |  2 +-
 2 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
