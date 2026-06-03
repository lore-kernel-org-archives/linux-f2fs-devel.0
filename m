Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C3CD6E55
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9r3L9fdlfpBO+dci//2Kq6DqCOCqgG+jRH/HSF+NxLU=; b=W4flMAsOAN6gnEgMERjp31B9Pt
	pX8ZYfkZCzBI7hepGlOXRmOgmktyMYqhpP+MP95p8EOsQp0BuUqgemHazmjRYNF6CpgcLjty4mRX6
	eksmOgpPsvA6GElkeiPSXa5Uz1z7g/UjRcxT6whlZThIBHOqLofd784vnKr+FmNxKie0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wUo97-0006So-Cf;
	Wed, 03 Jun 2026 16:08:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sam.moelius@trailofbits.com>) id 1wUo96-0006Si-8q
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 16:08:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKhAC5B5dhqPh618bXTUN+M7rgwoP9aBvOyQLY4L2Sc=; b=eCsSTiEp5T3sb4xR7guBSkUXou
 nWyEchn4SCruNk7vnzMMKWwVTgmRo9RD1srdOkSYKfSkRFajEsgjNz4J0aCl5ZsNaf9wiga55GICU
 O2jJYFg7zkBEx+yUKwxoVfWPe82V/x8QnlQLbRY5A0HztkuYkkNAD9XQOYBsww5RRVNo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EKhAC5B5dhqPh618bXTUN+M7rgwoP9aBvOyQLY4L2Sc=; b=D
 E//Pqa6UzAiDGs4B4gUj6bgOvXIG/dmmkm4Gw/gbT0dOrfijzrdfZcwSBAxwUKXeh6FCGOYUk/ufk
 V3cxX7syCkGKVLmjR5hjA/KxeNuBsILX3CrIVJAcXuquswdxnPZN+eUVJ3v287iW6E/HZgqeHp9OA
 sBarZZbEfLpr+rY8=;
Received: from mail-qk1-f177.google.com ([209.85.222.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wUo93-00024B-Ua for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 16:08:44 +0000
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-91578c374ecso189871285a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 03 Jun 2026 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1780502916; x=1781107716;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EKhAC5B5dhqPh618bXTUN+M7rgwoP9aBvOyQLY4L2Sc=;
 b=YAf9o1/hNW81HMyoIB8kCOYk+2opYcFRbc/vBDSF7m1nLeYelPtO82vZMu8wjEV6a9
 2w1uCjnF+o9M2BXdpMfiO/J+fzWE3u+BYCkDUweHNQ7Tu3uFqy4oj52OOIO27IbTq1HI
 PghFHNrTXtWVcovSuLN4ObvBG8wk8V+9ufU76L+E/SN4yUMd+JWBLyX90oGSTcnq+nVz
 o1G9mqWNK49oz/lBtqdMWjq9x+qe+37Tb3xYu5I2D17m8q9zKjaLE3VZCjhkPJpF0yFe
 0SB8VtZCewDmibuv4oyRfYL+sdgdNdvn1nOJJ51RmeFQGAwiUe+DMfgsLkwmhzjhKS+d
 wwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502916; x=1781107716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKhAC5B5dhqPh618bXTUN+M7rgwoP9aBvOyQLY4L2Sc=;
 b=Y2xonuB7bHlDy3CRf8ikRfkbtYNu8nKmcHL6O97h2kiFjb5p1Qo7T0cLpZmFCcv01h
 gBNAKuTdaugAxmi4P17tu+ZJsAU9dlfTtR2wVSg1Bp3HmGRCLIcusc+2v/l/vUEe/kh3
 Bkt13Cb9vY36+VtXM+njdoNgE2+s1hDt45DrK/w0rhRZNKwzNLKsUIFzkRfbAiqZiV/g
 +tSe+TXAydD194SStffsMCjjbnuNJ0aXD3lwHXGd/mdz9j++MOKmrrWRc/GfjZRn0/0k
 aoRtBEnYnMsbMLsgIkrQcjC4Hwd6OHHrvugM6A4iiTngM5qAXodHQqWHJmONxZAMsRND
 38XQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HLtWgsd4RxiSMNS9ZI0lHp1w/2Gprnl6qSMbn93QUOtYvUnZbZny7l00lSKN7LCAxLXXC9Rx1hw4tqrhcOyFy@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyKOputRSbphVGmvX3mo4VQFuLICdc3tOdJ+yl3yed47ap4hr50
 azbwreDxDJoE1OtrE5mhSC2aLgKIVw6uLj0iV64fp6uoNnHncVlviel8FkVG5I+zDSW+Gd3kF9d
 iNhKDzwA=
X-Gm-Gg: Acq92OF5zYMR1FuFLdJOXf6IJCH1geghLIezkoCb8OTReFH0wrrQh2Px06h5zvd55Vf
 sF9MthHz70N/lOt8Pol0hUOpJzh+kfiLlXxKkhm11HviPEjdrImX1ERq3waQLLJK3bGuRAbWkpp
 b1XVDh4cFUK5xGmZ2MLVy6F9M+F2fYXqB1PXeZ7KSHgrq8IkbZqD+kXXT3nyzc/oO9ITELHE3CK
 eSmjRlRVHZ6E4BqmRAUNnAkWAJ/YvPc/MRMiBvu/KU/ShEamcwq9sSaSjAkyyE+ZZP3fPQP0EJR
 hmFk/pQ9lt981asjjUhyTufEwMyKDWH7HlFTT3m0qjZlGzK75NSxALrszYOLaoCZOkh3C4WSlyQ
 BngBqjsr3/1b5jqlwdqwTRHYCd0g6QLox8q9me7kRinjoCMpx2XUAqhIsBo1gdpOQJ8vZfwEp/q
 NN/gm6XJ06wT1nQkMtSmS4KurxiuF8Qe7r6+wW2w==
X-Received: by 2002:ac8:598a:0:b0:517:7277:9362 with SMTP id
 d75a77b69052e-51778751a59mr51776541cf.48.1780499506595; 
 Wed, 03 Jun 2026 08:11:46 -0700 (PDT)
Received: from localhost ([161.35.96.86]) by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-51775dd2e53sm25387211cf.24.2026.06.03.08.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 08:11:46 -0700 (PDT)
X-Google-Original-From: Samuel Moelius <samuel.moelius@trailofbits.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed,  3 Jun 2026 15:11:40 +0000
Message-ID: <20260603151141.15635-1-samuel.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wUo93-00024B-Ua
Subject: [f2fs-dev] [PATCH] f2fs: validate inline dentry name lengths before
 conversion
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
From: Samuel Moelius via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Samuel Moelius <samuel.moelius@trailofbits.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Inline dentry conversion copies names out of the inline dentry area
before checking that each recorded name length fits in the available
filename slots.

A corrupted image can therefore make the conversion path read past
the inline filename storage while building the regular dentry block.

Validate each inline dentry name length against the inline filename
area before copying it.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
---
 fs/f2fs/inline.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7aabfc9b43cb..4584dfbe3fb8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -507,6 +507,10 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 			bit_pos++;
 			continue;
 		}
+		if (unlikely(le16_to_cpu(de->name_len) > F2FS_NAME_LEN ||
+			     bit_pos + GET_DENTRY_SLOTS(le16_to_cpu(de->name_len)) >
+			     d.max))
+			return -EFSCORRUPTED;
 
 		/*
 		 * We only need the disk_name and hash to move the dentry.
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
