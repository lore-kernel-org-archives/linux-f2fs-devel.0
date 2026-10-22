Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68C606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=beyUIakp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MXrBo09G;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PnIxR7lh;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4bP49Mj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=5bgbC/IJ30CoBb8qX8O1F5de98gDOWB22kr0crGmFa0=; b=beyUIakpshQFktOEk2ss9LFwzG
	Bg9VGcv1M6W/2LapumV8PhRJ+nxark5FpMXS7nmQQMUCA5QK65HoR2UkVeUjz5gmoF462QK9JmnsZ
	KiFtqPwZ3BtgDk/g5opN/rfEle5/9N+OaMCi76CQLS2sSgKuNswpJqHXtEYVN1wrmFcw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsbR-000000004qN-3n2B;
	Thu, 22 Oct 2026 13:13:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsbQ-000000004q6-05PJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:13:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XegirbRv61k8O/v8C9GqnTzvwKbCvCQRqzC7ceZuaqQ=; b=MXrBo09GZD3U6VXzPAuev/XhtB
 fiPBHgVgByTzXCsp2Ei4nUis0Wop8/cWUEnWThZ8REZOd+YVhbBEUenMzQ/XFRPQRCkB1okJTk5Iz
 mpTbdi/o4nhkQtT7379ZGnBh3alKP15b23pzuBwBDZmCnwoa2raZBZjdk4tBcR0nA4vw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XegirbRv61k8O/v8C9GqnTzvwKbCvCQRqzC7ceZuaqQ=; b=PnIxR7lhJ66s1EimGHsRGsTiJr
 zyqCwhh/R8jZ2UIs4aOS1RWZcXXFb3i0wLxMZIi7SYBN+D+YJ66GQkShpMQuOThVSAuhAYB1ozpXx
 CS8+glXUN/jTLhOq4Bx8LLw69GaX5GYi9APe5O7HdAB9JwnyoGIqSZrTo25n21fT1LSs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsbO-000000001uu-1jw4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:13:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C5406602D4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5AA1F000C6;
 Thu, 22 Oct 2026 13:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792674776;
 bh=XegirbRv61k8O/v8C9GqnTzvwKbCvCQRqzC7ceZuaqQ=;
 h=From:To:Cc:Subject:Date;
 b=Y4bP49Mj/nxRncXjpAF0hximuF8uFviKaJ0SvcxSEtZr5+LeebPpZA1ivo4VxTolp
 OuLCEOtpOnQuR8/9jGyTWn9T15B3nAVF3A+MuoZrn5qovjXA9OdMbTKUtwV0a7l+gC
 XOrjoGPerPsJ8iT422KCuSfJ15jIbIF3+OaNSF1nigc4laudwjp28oRDzlv/0Aa+EY
 bl1/n05RGOezwuGfe2ERHCOyyE4ojAj9VBTZadqEeNWMigs8RgSjbnUEaw+83eqmw5
 kCsHgo2RoR0SdjyXfsQHXTYc82+KJOENx9vYufrTTEPH+0r21Wzm1cb7vp8r3QhBQ4
 +wbmLYN8JFBcg==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 13:12:48 +0000
Message-ID: <20261022131248.3440239-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsbO-000000001uu-1jw4
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: fix to align RO image layout w/ block
 size
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

f2fs/015 fails w/ 16k block size, mounting an image formatted w/
"-O ro" fails as below:

mkfs.f2fs -f -b 16384 -O ro /dev/vdd
mount -t f2fs -o ro /dev/vdd /mnt/f2fs
mount: /mnt/f2fs: mount() failed: Structure needs cleaning.

F2FS-fs (vdd): invalid crc_offset: 0
F2FS-fs (vdd): Skip to start discard thread for readonly image
F2FS-fs (vdd): SIT is corrupted node# 0 vs 1
F2FS-fs (vdd): Failed to initialize F2FS segment manager (-117)

and fsck.f2fs reports:

[ASSERT] (fsck_chk_curseg_info:3747)  --> Incorrect curseg [3]: segno [0x38] type(SIT) [0]

For RO image, f2fs_prepare_super_block() hardcodes the start offset of
segment0 to 8192 bytes, i.e. two 4k blocks for the two superblocks, but
w/ 16k block size, 8192 bytes is only half of a block, so segment0_blkaddr
and cp_blkaddr become 0, then the 1st checkpoint pack shares block #0 w/
the superblock and is overwritten by it, so kernel and fsck can not find
valid SIT journal entries in the compacted summary.

Let's use 2 * F2FS_BLKSIZE as the start offset instead.

Fixes: 50fd00b ("f2fs-tools: Support different block sizes")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 33d3da9..7390fa4 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -316,7 +316,7 @@ static int f2fs_prepare_super_block(void)
 		(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
 
 	if (c.feature & F2FS_FEATURE_RO)
-		zone_align_start_offset = 8192;
+		zone_align_start_offset = 2 * F2FS_BLKSIZE;
 
 	if (c.start_sector % DEFAULT_SECTORS_PER_BLOCK) {
 		MSG(1, "\t%s: Align start sector number to the page unit\n",
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
