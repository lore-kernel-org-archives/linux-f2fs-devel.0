Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54C606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PzvF5G9g;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=liPn50U6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M1scspiQ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pjyRNqTi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=O+CP4Ont9hSCbm+BhcSXVdGpldvGxfyci2RgQ5KtDCQ=; b=PzvF5G9gRk3XD3JNM4efm9G/W3
	Sqah57fx5IzRkA2whPUI44wVhjEJO0rmmwoDmi+eRnoaG2zncXOuhI1rQvWOkIxMMnVcQY5vUmBxQ
	J8w91JKtTydqzDOLMzhY6rcCvNN9Y2INkWndA5XipeIgs63rJKkMe94JOPaV6QW6GU3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLII7-000000008V0-1gnf;
	Mon, 26 Oct 2026 10:50:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xLII6-000000008Ut-0vYy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dyIOxsTmkVspFMyxvRPipvvAUXx4yxejy3ONSysLtPo=; b=liPn50U6AforJW13lRnpBjXkLe
 BQfGSP+1cDOSzEqCjZJPQHEfRmw0CLsdqfBaz6/7sKNpBiuT9+nQENGy6h4yFSIBuXDNe4DnLaKY2
 4+eQ83NFGRjGFXUSpX6MqiWfxeF4zWzR/9lPHfBoCKQiiCX9qIw2RHcyuwC433GWAuI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dyIOxsTmkVspFMyxvRPipvvAUXx4yxejy3ONSysLtPo=; b=M1scspiQSvsuv94qMgytKPAjyu
 TVmRrYkT7qQTFv2qM/czXpekAGtGATQk6DZ8NYgVcU5lfJEh7dCanrEcRTbJ3i4C+N6vXGcK5YdW7
 shJ9bwSn2aEhnSey4iGq1ci2/K5lBcPiVao9Q3dInH4w8x6FA6H/YLiiec+w2pFeLbZU=;
Received: from mail-dl1-f46.google.com ([74.125.82.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLII5-000000004Vb-3OZN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:50:58 +0000
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so274084c88.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793011852; x=1793616652; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dyIOxsTmkVspFMyxvRPipvvAUXx4yxejy3ONSysLtPo=;
 b=pjyRNqTiOAecHDGde68oV9MMKEWjgV9PWRE9JkJ7aIDH7fnGoaIgldD8RiGDs4PyTJ
 1+o3IcuOXfd17VrQ8FvMUE9yhpwGQtaQGsgz0ldMFl7Y4tdbpSnto3iQ9k7SyvQt6dx5
 U9VDBit12yjnRlbHYcRKOHcoJAHNDuF58zLpcZvYTKbNXla/KvQWJwQcleMOl/ZIWTFJ
 ghJFLX5Nsw04zCI2QpmHYZ86Z9s3VmLCDeXNsidSXYxHyMxtGLfck0W/R8KPu3U2q81J
 NbpRibY0fyUqS5klME2pQsJpWAAUp/FeBNYgSm30TIGJrRaGI9IG3PJOGudUSpAOt/H5
 htOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793011852; x=1793616652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dyIOxsTmkVspFMyxvRPipvvAUXx4yxejy3ONSysLtPo=;
 b=z5EAkLPAiDFZvfU/84EjXMV9pjxGWpyi+su3qMzfZzfTsctHr22uLo8wHl4wsGntHh
 zEf5Y6JwNGV6tNDJIaO2An0/nW5eJ+s6Qe5k4SGRUL5LWUBWwhpx0cbSrV63TxMe5Y8e
 Em3sXZHg+1uh7SSGWxlELs6CChYaPMsfXiVsF2PD9IiNGra4YIEqvQko/piB3quPzZQ2
 h7TC1e3/go/pJ968DTcvFjB7NTNS/CJcLN/pQpTGayP3Z5udJKHXPlg6M3mHgCGm5ytO
 J4Yx5lPRGDxqGZmq3eE3NtzC9kLobcrlOvriue6K6dt/7zjhtczEwrNm67Pr9Q639962
 Y+EQ==
X-Gm-Message-State: AFq9FYKK9cLCn/j6+7Y6MB0wHMxwIHvKOBVIc/3eAavTq7YVjWLnIJsV
 5aM4bRaSRg/raViW773y1qy4AJH4r+8VTlfPElR/+VSF8c453xUDxs9w
X-Gm-Gg: AYBFou29EoeDIQVlXJrgRfOUrI7ETuS8ErNTkI0PD3llNwcbQ23bwfJrRaxFY2LqIlE
 qmThmYU+5Y+2Lu8boMqVUn/a+rt7qjeZLqJeXSK9dqxHMrVPnbQk9k+0XWCCe2jr7XTUDNIfbGn
 XEHZsacmpfea0ioyeWpz9AzGRsm6tf4uFHPRyJSmtJtjEUt/eN8YFvVRl3YL0bqI9YnsHcFoBsP
 NMbLO7sCk8ohWgDFqugrDx+qGJ/k/dwmda8jIvy7cq1V3qnCbIQbk2CG1U1q201UAyF4K1Zrm04
 iVgZ8bVmaxKw8VCmpeytcohuxoMB5aHOtibuT9gj24h86WwxLG2mwBsWLdEklj+OZvuqES1zXuK
 /OXmWSpW8K9Ik16Kg7BoiWlU52HUDQaqCtENDDh+OiXs1Gu3R4X35HLO1MavI55dNyXLkJ2H5Pc
 MvmIntpQQSRZjF2B7prKVMtV+R+SAI0dyGKULMO0Hap0p5AAZkCkgz5QWWAO1CxQYC1PBoPMB/A
 18O0ftXpizv8YBQriGVjrhSgITysVsttNdX5ZGYRzLntSbhvjo2BeX2uVEUOg2yyiJ8788gpw8A
 Ao29lr2qG1vNi3dsW3I=
X-Received: by 2002:a05:7022:f502:b0:15a:9834:73f2 with SMTP id
 a92af1059eb24-1a243f18c54mr1365627c88.38.1793011851969; 
 Mon, 26 Oct 2026 03:50:51 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:50:51 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 03:50:38 -0700
Message-Id: <20261026105042.1148554-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLII5-000000004Vb-3OZN
Subject: [f2fs-dev] [PATCH v3 0/3] f2fs: fix dentry recovery and MAIN_AREA
 validation
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v3:
- Add the missing Fixes trailers to 1/3 and 3/3; 2/3 already carried its
  Fixes tag in v2.
- Add Cc: stable@vger.kernel.org to each fix.  No code change from v2.

v2:
- Rebase patch 1/3 onto current f2fs dev.  recover_dentry() now takes a
  struct f2fs_cached_block and sets dir from fsync_entry->inode; the
  S_ISDIR() check is unchanged.
- Patches 2/3 and 3/3 are unchanged.

This series fixes three independent issues found while validating crafted
f2fs images:

1. reject a non-directory i_pino during dentry recovery;
2. reject MAIN_AREA boundary underflow in the alignment fix;
3. refresh the superblock CRC after that alignment fix.

Each patch is a single logical change and compiles on its own.  All three
were validated in QEMU on the KASAN kernel: baseline trigger, patched
no-trigger or clean rejection, and a normal filesystem mount/write/fsck
regression.  The baseline source and build were restored and
hash-verified after each run.  The series applies cleanly to f2fs dev
(fd106ada4dee).

Cheng Yongkang (3):
  f2fs: reject non-directory parent inode during dentry recovery
  f2fs: reject MAIN_AREA boundary underflow
  f2fs: refresh superblock CRC after MAIN_AREA alignment fix

 fs/f2fs/recovery.c |  7 +++++++
 fs/f2fs/super.c    | 13 +++++++++++++
 2 files changed, 20 insertions(+)

--
2.34.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
