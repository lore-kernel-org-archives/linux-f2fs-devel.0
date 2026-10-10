Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C040CA9EC0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DXzVPzHjn3BgZ2MmZzcKU8ZhY61P8p1RoMEy7X173r0=; b=OJUspZEh04yF+E0TaCCam8AMFB
	K18MQmnKIUy8HrTrUnSHf60e5m7qrKHDTlKzyPkx4Bl1s873Q1lYcgTJ35jJ0g5LG8iQZDIA+LVWU
	A5mI3YrFyEDyYVi8pw0QBcCzNm/iDKbOMHeTevNW2c2qsCGOhY6/yQXKkaTrge5XmJeE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFbzY-0000c2-RC;
	Sat, 10 Oct 2026 18:40:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hengyul@cs.unc.edu>) id 1xFbzX-0000bv-9J
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 18:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y+aWrByMnnkP34ycFrZEpngJ9FZ+gHc4fELs0PSjAVk=; b=OIlR81BGS3PFTW25GCZQrRLFam
 cxU0j6va6unL5wyvu82evrRej3nGVqmFXZJ0wR1xlYYXNyRtoFUspGPmEAQPGc/3O5SU5a/G8C1Dv
 3oblAlKy40ZEjaFMTI/EjS9YAW0G1AsNYGFXbZuoCKyWhOjZcR5FHJHgox3nuVl3tOVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y+aWrByMnnkP34ycFrZEpngJ9FZ+gHc4fELs0PSjAVk=; b=i
 XZZXqMYFt3zRSSsqGlq9fNJpR7lK0wq8otU2BgchEgtDbF4RqOGFItPny7YmLWvSahvxXyJ/Tpcty
 6KlwiSN5hJ4urFIYrLuUczJZEg53CEkYagHbTv/nC1W48qy/S9E+mY5DpXRqHrTh1vpiTz0xNyBqp
 B4GdlstSKG218l6Y=;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFbzW-0007hV-Ih for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 18:40:19 +0000
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc4b62d118aso384275a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1791657613; x=1792262413; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y+aWrByMnnkP34ycFrZEpngJ9FZ+gHc4fELs0PSjAVk=;
 b=DpLQ2ANnMYx03AAldPOUcUzT0cPIsXGMif75018woNMvW9xZLrfoYW04woPsz7eAM1
 CDBjPWY6tZGCTQg4av2YpdCOa3uM3rpoNeEQqcDUIK0ZDPuCPfaC8kLkjYOqKIxm7+5n
 fzArDx13Z6rkW1Clh2NMGTBqWUM6NVKs3d3RrD0J0agPUPWazx9edS0nN9UvyNhX2dhf
 4pmGp9dZy+c+46jz5ZzklZs532PxLLHKX4PDJhefHcQ0MFRXqMbGBY3djNcmdXiasT1O
 dTWvrL5RPrlKdKdD2/eVwy/QhIzcLDbS3ipNBycWjLf8v8MAQOtUGllhpUVbVHlIEQsX
 /cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791657613; x=1792262413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y+aWrByMnnkP34ycFrZEpngJ9FZ+gHc4fELs0PSjAVk=;
 b=JFgs61A4vpKBaF/K5n8YnFz0QP0+7LVmD0ecxW+WZhLTzlZBy1RM2TF/lgG1u+Gw3c
 kXre+bo54VgsKHcaEawm25dS3+A5rUgRIl79fKXsw28nHqnUlER4n723zNDdk5LM4aCt
 icKRINWRyNe0cudTcIPi/yHTPjFKhfInWzvf3rwuM3YDpETiFlKDRj2LDBDY2Q/lIeIR
 3/2dtf47lE/fEP5UGaS8ZAbFN9LiIUBgJRiMrUkbCCIJPceK6YLfW4lHnGevxpJUKXvt
 qYq457fHwshDHWIFVoh+rOZpJTfWSkqI+glMBbn15BRFi/7/2dleZleFqj5H8eqyXtAz
 IA8g==
X-Gm-Message-State: AFq9FYJ53cYxTmeawFpQozETslCQASEpP2x/J0N2ZsqLbKpeQM46SJn4
 EfI3iueFn/3TE5zMb43hvPOm4Y0Yjiewif8SkHDN5ANuvAfcq3ZYdz9eGzFnzUT2I0MP+MeFyCd
 da96v+A==
X-Gm-Gg: AYBFou2Os3P0LG7gFKQJ2+ycXSPhpD2Pf+z95KIpWSWjRrN6pjay/J+vDpKVO3fEFw0
 qVIAFUi+EgOT1ldlI2hVAguSVnoBIkpC+OY8nQP/Dynnf+EEW4bkuV0ZMgFIT1W/z624WtSxs7B
 89sh0k1AoqPmA72hD7Vynl0+HG3+K6CEpYiFr+oa7DciuepCugXImIQL3NW0C9+I1el4R2GvCyJ
 lmikJtFQSITUabeMQkf6NupdddaWXVi3myP/igg/U/ihhlzOkHZ4UJSY1/B5Gwbi5vR8ciOFO/Z
 yudFx4v4re58tDiaHzpdQ1luq0LJOWy6trXROTf10hZX8i92eRWIeG2mPOJAIXxB/Qf/Mp26jvc
 Z4bcJxb2XMsRYkZntgFdHhjgmuREC6UMT+4jG3gFB7iu8hYz765CEuKaGa8y4Cd6NMHnoSpLKzw
 YBBL1K/0C5WKZLk/khs7GkInlPICi4Ng02yOc/TyCR6kvQU6ITw2ygaq/y1n0JiWuyINrT9Inkm
 fWMRP6D+QvRujH4iDAlLA==
X-Received: by 2002:a05:620a:c53:b0:93c:779f:3e02 with SMTP id
 af79cd13be357-93ebd0c0021mr871221285a.11.1791651472163; 
 Sat, 10 Oct 2026 09:57:52 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98488aasm459739185a.7.2026.10.10.09.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 09:57:51 -0700 (PDT)
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 10 Oct 2026 12:57:50 -0400
Message-ID: <20261010165750.509939-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xFbzW-0007hV-Ih
Subject: [f2fs-dev] [PATCH] f2fs: allow empty strings for journaled quota
 options
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
From: Hengyu Liang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: joannechien@google.com, daehojeong@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 2a3db1e02ce0 ("f2fs: allow empty mount string for
Opt_usr|grp|projjquota") added support for passing usrjquota,
grpjquota and prjjquota as flags to disable journaled quotas.

However, it also replaced fsparam_string_empty() with fsparam_string(),
which rejects an empty string. As of now, mount(2) and
fsconfig(FSCONFIG_SET_STRING) reject usrjquota=, grpjquota= and
prjjquota= with EINVAL, although these forms are still documented in
Documentation/filesystems/f2fs.rst.

The issue can be reproduced on an F2FS device with:

    mount -t f2fs -o usrjquota= /dev/loop5 /mnt/f

Before this commit, the command succeeds. Afterwards, it fails with
EINVAL and logs "f2fs: Bad value for 'usrjquota'".
The same failure occurs when remounting to clear a quota file name.

This patch will restore fsparam_string_empty() for the three options
while retaining the flag entries, so both forms are accepted.

Fixes: 2a3db1e02ce0 ("f2fs: allow empty mount string for Opt_usr|grp|projjquota")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1314b6ccced9..3867094b25f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -338,11 +338,11 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag("usrquota", Opt_usrquota),
 	fsparam_flag("grpquota", Opt_grpquota),
 	fsparam_flag("prjquota", Opt_prjquota),
-	fsparam_string("usrjquota", Opt_usrjquota),
+	fsparam_string_empty("usrjquota", Opt_usrjquota),
 	fsparam_flag("usrjquota", Opt_usrjquota),
-	fsparam_string("grpjquota", Opt_grpjquota),
+	fsparam_string_empty("grpjquota", Opt_grpjquota),
 	fsparam_flag("grpjquota", Opt_grpjquota),
-	fsparam_string("prjjquota", Opt_prjjquota),
+	fsparam_string_empty("prjjquota", Opt_prjjquota),
 	fsparam_flag("prjjquota", Opt_prjjquota),
 	fsparam_flag("nat_bits", Opt_nat_bits),
 	fsparam_enum("jqfmt", Opt_jqfmt, f2fs_param_jqfmt),
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
