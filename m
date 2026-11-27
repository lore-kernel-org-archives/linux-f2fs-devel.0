Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08602606A6A9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZIw03U7f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HuXP6tHi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lf6vVcR7;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TemEl5EG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4HI6zQubEQntSce7XT1id+Xr5w4qmPDVClQ38cpZGXM=; b=ZIw03U7fT1IO5EeI+r61X+Q5ie
	AZNFm8a7I/TIe7EefeSt+dAFI+aeZxOvxn2Rn9scvHX47wo2moXs45pGUAwehcqOcxPgDVtOh2mf3
	fY6hAm2bMBSC6l4hP5UQvO7sfDMOCWKQWHzd/40kZXLPu7bnESbY3MiDY/81m/KrZmHo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWrdo-000000008G5-37yO;
	Fri, 27 Nov 2026 08:49:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <qwjhust@gmail.com>) id 1xWrdn-000000008Fy-35bE
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 08:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=; b=HuXP6tHizSzHGlESencX6c8efc
 /SjFY1mYXT8HpzT6GRp1HzVS1VJ9PYNPkI8da2UknI2/zC9mTrdnh9iMTgrAL4zaLh4dEdka7NNLW
 w+voFNR1Ujh9xdEBfwP1ZGsV71yhBWB0xKVf0wjV15aLnuBwpw/idqDcm+v0jA4yEnS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=; b=lf6vVcR7cpe3wcuCeTyao4RB2l
 8meuAUX1UPyu9rTUF5pKArHbo7NFVS5STUnYGH1dsDeWoEZ71Eu2FwZEIVr2HvpjFI/PLLbvhbl1r
 WsrUVNIGFuT1BiXb5N0x3xciNt7bfyIEFl2p7yOsUNS1D/kfti2ozIp9FksFiG1mmWE4=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWrdm-000000001sU-1GBR
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 08:49:11 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8a05b210703so3709175b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795769344; x=1796374144; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
 b=TemEl5EGKQN/lC4U3wMHiI3PjXBeIkkuvBUKV9t4cgIM15hvb0xFgsryiM83ndUTOx
 oy8hdi1YJv8zy/yxDbhIz/2RmQw21zABWE5J05nRreHxXz42yinb2ob5/LNo321PvR9I
 KR2bqYmNgJ49cc2KlmjOLrwQCKqpWoiP1cbkCKUu69LPQDJMYPIE2qT/lYQ7NIVvD+dz
 ryBer6Yn7wMhIbSAnM2elblLevHfZQwbv1Cszu+rzP2OL1wXSA0dNhteKOjvE18X6ATs
 1OrcdQ2kxBhlcwS3M37LaF7tt5qKxOlGdFwnKx46wx4WyBfJUrxGmZQDrKdlW2HWVuip
 c+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795769344; x=1796374144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
 b=EZhOjWQksko6XWtluDe+ZytxFlpCo8TXuNz5YgXpiYkPG9r9NWX0w0+FzEXSNM9gb+
 VarnJETG1OSyD+rf5fSBXOESiq59xp7YScsgEJjRHySG74VSrZGGQjEbtNZwoRuKUf22
 dA+rKeCCKoWrGP3UbyY24P00/+Fu08dF8W1HH9M2hbWIv/utMNzMv1QwNoy/GRgyIdEG
 ShjFs0S05STEc9eEqRB0epLGEgjHQ7P3k32Lx0lCafhiGymsEbO/TFi3KGIHvYmHe2Ee
 YobDNzo0Ik2p7lBIXXt/V9Vo68QFGjrcRvYGdaBug/K3X9uZLPVmnLqH4XHfMJdk7Weu
 vFMA==
X-Gm-Message-State: APuU4Z/Gs72WrZSZqeUhf3IgxvRH7PyIf25RSKPhN9OCrJAIfJ3VS6i3
 gtxK1ZgBbpW7K8/AdMhY7N7DN+OmoxrcJNx3ikWq7HW8TedQTU5Y87pV656vdHM9
X-Gm-Gg: AZFdTZciM4j5t4jgePka6mEzN70WMIHJNSbkSL8jlAAVFuug9vjqNNLuivfPJbXSrFn
 y4wglNG3jOtHmufUJTpybb1zUY8HipQn20l5vK6Z0hOiEeJajKqMh4noa9xHldvRCv7qRleQeKl
 fRyYnqywblLelMJXumfD4JXOJu+g09nm6ivn8mXiG4kI6vkGjuQwG3Ch5ORJ2IMURzYUzU4q4Sb
 6maxBDTNTYnJlT27YGOwJn6GlacE/C02KtcJVMgasmvY/VW10Q8/fthd76ISR0tQWm/REaMQMT2
 GakVV9B48w58cFwjfvs+DEJSKKwV4gF4aR91C4+Qh/QVrbNhiRsspwwVT7BF8f3SSL5i8KVjlQl
 z1e6RTD2XoBDN4CzNfgK1x8qSLFd61Y4GIzjL0zliG5Z1/n9cwxcmDCfHdq+RcCAQM3s3KiJj6d
 Ft8vb9ouWA1zcyCNu82uNZsTTNDqRXhu6o21doY6xvF+ZKKrJcf5y01ec7BYhfgoecrQmtBB9TN
 hQS7u5XR7GtFwkAKp4Yi8Hf/+0Wgo/vyYpwNxNPF+tRjTgqWkHBWc0Wt0C1wHYw6PMDRA57BpQU
 KLNo5QUM+8+4OoQ8/pTztPGmZwklRLBCPm+eoKfjbPJrMf52Bn1zvimONMaaO9hV7kcAUW16xY2
 ZXgTUwKW7stk=
X-Received: by 2002:a05:6a20:db97:b0:3e9:176f:ab86 with SMTP id
 adf61e73a8af0-4014bc4b23amr26347756637.44.1795769344544; 
 Fri, 27 Nov 2026 00:49:04 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 00:49:04 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 27 Nov 2026 16:48:45 +0800
Message-ID: <cfdfaea72b21b8abf58cb250495150d92e73beda.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795746008.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <cover.1788795700.git.qiwenjie@xiaomi.com>
 <cover.1795746008.git.qiwenjie@xiaomi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWrdm-000000001sU-1GBR
Subject: [f2fs-dev] [PATCH v6 2/2] f2fs: enable buffered RWF_DONTCACHE
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz,
 syzbot+cid5582b8164122eda@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for
IOCB_DONTCACHE writes and advertise FOP_DONTCACHE.

The address-space write_begin callback is also used by internal
callers that pass a NULL kiocb, including page_symlink(). Check iocb before
inspecting its flags.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v5:

- Rebase onto dev, using the existing fgp variable and preserving its
  folio-order handling.

 fs/f2fs/data.c | 3 +++
 fs/f2fs/file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 37d74afc8b26..f3559c27d44c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5622,6 +5622,9 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	unsigned int blen;
 	int err = 0;
 
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c80dbbe76f8f..571a848c6af5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -6274,6 +6274,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
