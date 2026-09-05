Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8478C79F8B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGXkEtIsGNxRdAIBYUb352KPA/dF4KpPMz5VlaOuv74=; b=jzzcbHWY1XLeTEzv23D6JlBCR6
	a27dhbqBPwc8p0MWKGPzpGqKwdUne96VrJ1SuzcGRy7b6dgTZJqhCFCLUrxgHsRj2W4o2+qPZzi6M
	HYBNwPX4F4vFp6PfWsYaPFrdF7KCpuZa4F/OxE1dNCIM/BkLdwFjA9DPLP0UeMUWMGh4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2qT2-0007c5-Nq;
	Sat, 05 Sep 2026 13:30:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x2qSx-0007bt-Jr
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 13:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=; b=YE+XR4whZU2MGSnlIDoNKDFeM3
 x5jxQqhB++DQJm+OjUGH2jwzaZmuDGnVhLHPDcW7suOzKnc0g3DtsiJiKsN9x0VQXLnyi2IyNwMcH
 MfusbIAGF88o+F6Er0B8LC6pK6o3E5vlWojW9jaFjJHutzqIIE+LGMYKL+DQnfC82PaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=; b=DaGdbtTFCEZvZVbEvZE4m26hky
 bG1Y/AUn4caCyipSlnyjZxvwVTdwrDkb0URH1jPhfoTbPf71XzBxQz9QKMBxr3pM9tkxg0bgaun7p
 /gvp3WyJ/e+rNsYHBLI45Lvq7TnCvOuEm1yF7fFODZMJDjO/Sg8fl9uQcbzSlwPdpric=;
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2qSw-0006kO-Ue for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 13:29:55 +0000
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc439bfb2d8so1314213a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788614989; x=1789219789; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=;
 b=MHXzdcrRmHFTKAXFcetjnrjCyzM2Ke1I7TlE6C06UEgpebjiHR+5ABjcxVWev36Zt2
 +6FEsDE1JNrUB3belCXU5iPYx2VTreD3KvsSFcsAWgzPRN9OpIjP55bHu0Cr7jLhZRxn
 +ggQATrQuYO33aBOxVA1VDiBoEBgXeklL+IMjynatP0sCW8jwv1PG41baBNxRUqFs7VG
 I+1ARBYio7iY+7Pednt5hkr2wecaau8HMIwVhyQGfKHQrMEfaZoeWRw+zRcDZuoc8pQn
 zcn+10LK7CXzJe3yv/jR/rg3coFx3ypsj2qNqTjP9Rk80PRGaf5lng+W5tJqWk2pip1a
 c8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788614989; x=1789219789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y4u0GWyaTeRSvMtQ0YnsmqSEps2foZyTtNF0hC2tn64=;
 b=UbykHWIuj2tkT6hYd9lrUO8zkr8vb09uKNc3fwYD+/HhpFh4I2Gt1YVqxA3Y6AdxGj
 v0kGanLsbX2rMpNn9mO//7ZnrtkeaCyZVmypCK7D0jIZp+WtzDl1WIbCCkbwBOqLr1+2
 rl2r2CZOyu/ep6roBu9azMnZikkMD2xdfkiqX7CRxwEODmgr5O0M0ZYFb/8j/SxYWIs/
 JVyuAIGLjLK1XT7GgUl1cBbwr6Lyh4wfRuBSVsgjXifh7eJxLmF3WPDvCO4H0Cq6mKtT
 6IubXYkRtsQYtPiCWQXrLasneUFzU0/ZGlGr8gDH3bAqCaKpfKTg1MkxATcWJotz6yIa
 7Byg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjn0btD+KQWrVNGEnbFl86RXgeeGIeZWe/qlJGvYt18a7IVrBjTC2c5NJFDJn+CgoBjCGLuUo2ruPbQxaXEkJU@lists.sourceforge.net
X-Gm-Message-State: AFuF++nIMmMuWB5bSvAPTGciIHQ5oLTSC9wyiF2jpNLVSsbnnT3tykE1
 x8zlIT4j3pHjJsm8+Rn4LunAWF2BFAxEAK5SnTEjlGdE7/0WMuEYQV+I
X-Gm-Gg: AYBFou05NeN+yOPd1LTkqbYgZ5i6HOpsS0Yp3b9HFjqVeaCBbqj8TSfWiu7WVcWgp+R
 DC2Ypo8UWG7/j0ctA4INcZDab2qGI6ebpvPG0SMYu2eAlz+aV7IUmah2AWTHY+JGIhOXjZAnvNL
 9wcvAV3cJfd/NGDfc+sAKwSE77pANizN0bG1N14XbtuaohZulQgTx7cEwlS4iAFM0uRRmt1F6nX
 g0GmYsPk5MBc/uYibEjWOemPCnOCFT/HyLKoIzw8if+AlHcrj6AHTFA6/5uex5IMCqh1Y+Kd27d
 OhHM0pFuKETIh0KpMndfpt2qfPWxfA14fvtHAXno+U5zyK7YCmrgP5em/0G7MYc3H60cp2DPPxF
 qM3J4pP3m0AjBFCzzgQCdhTBMNMHdKD5xZNjB8+Cas6JBlGpolMSDTL8CaUaTHoG5/wam+B8hle
 lc1Xy936b26DOCnHukzuMZB1S8NoZm1PhGdYnJ4nPVcnb4i3+WSLJroBD1E0keE6dmn0v+OeBn9
 1pxfdlEB3B9aEffQzSICw==
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-39b2614df74mr17583898a91.1.1788614988974; 
 Sat, 05 Sep 2026 06:29:48 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c397b1sm16146499a91.8.2026.09.05.06.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 06:29:47 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Date: Sat,  5 Sep 2026 21:29:40 +0800
Message-ID: <5fdd4d960a6b47ab7cfa6ef0f44fb575fc45d1ca.1788611415.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
MIME-Version: 1.0
X-Headers-End: 1x2qSw-0006kO-Ue
Subject: [f2fs-dev] [PATCH] f2fs: handle NULL kiocb in write_begin
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
Cc: axboe@kernel.dk, baohua@kernel.org, syzbot@lists.linux.dev, jack@suse.cz,
 qwjhust@gmail.com, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, tz2294@columbia.edu,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Wenjie Qi <qiwenjie@xiaomi.com>

The address-space write_begin callback is also used by internal callers
that pass a NULL kiocb, including page_symlink().

Check iocb before propagating IOCB_DONTCACHE into the F2FS-specific folio
lookup flags.

Fixes: cd5bc4fbb900 ("f2fs: enable buffered RWF_DONTCACHE")
Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
#syz test

 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e816c9349a..63625ab3f1e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3890,7 +3890,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
-	if (iocb->ki_flags & IOCB_DONTCACHE)
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
 		fgp_flags |= FGP_DONTCACHE;
 
 	trace_f2fs_write_begin(inode, pos, len);
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
