Return-Path: <SRS0=zgyR=IM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57719C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 14 Mar 2021 22:27:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA3364E84;
	Sun, 14 Mar 2021 22:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA3364E84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lLZDI-0007WG-Rz; Sun, 14 Mar 2021 22:27:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux-f2fs-devel@nodmarc.danielabrecht.ch>)
 id 1lLZDG-0007Vw-Tb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Mar 2021 22:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Subject:Cc:To:From:Date:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fhMFLaAB3pJ2xywM0tafouVPY+noKI0Wepc4P+VrqSY=; b=JJbQmIUQzZkDVz/BJbdPGSriB
 GwOBXHq274Pey59U6eIkbNSSAWo1WwKHKacs6Kde8A4gLyIulFz7zYpN+39djN1KD0FbNFCq71elC
 MUOmF1tFs7reTdVYJG62RBzW7BREvjURdZpEuZcf6QzpLsJp32hIQqnCHvHz8dmtSHL3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Content-Type
 :MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fhMFLaAB3pJ2xywM0tafouVPY+noKI0Wepc4P+VrqSY=; b=W
 irLAxWGz+hUWUYCbvHytXPReAS2/JpVve+ogm7Ce1JORA6raXO2Xj5dTUT2s9JlmHDgDnf/yLKyOi
 9nVamzMcnEilYepuZjh4Q4fPf2PI4EjYPGc0vrhEVSMZy0t+FMZqJMKp7SEg7q/jA9KVQirWm74L7
 EJ63qG8na+syLKxY=;
Received: from 75-128-16-94.static.cable.fcom.ch ([94.16.128.75]
 helo=abrecht.li) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lLZDC-00GDxz-3V
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Mar 2021 22:27:54 +0000
Received: from mail.abrecht.li (unknown [10.60.1.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by abrecht.li (Postfix) with ESMTPSA id B80E62D99928;
 Sun, 14 Mar 2021 22:12:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li B80E62D99928
MIME-Version: 1.0
Date: Sun, 14 Mar 2021 22:12:24 +0000
From: Daniel Abrecht <linux-f2fs-devel@nodmarc.danielabrecht.ch>
To: linux-f2fs-devel@lists.sourceforge.net
Message-ID: <2f3255b625ce528ceb317b702ca7e0c2@abrecht.li>
X-Sender: linux-f2fs-devel@nodmarc.danielabrecht.ch
User-Agent: Roundcube Webmail/1.3.16
X-Headers-End: 1lLZDC-00GDxz-3V
Subject: [f2fs-dev]  [PATCH] Add -P option to preserve file owner
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
Cc: jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I use user namespaces & debootstrap to bootstrap a system, and then
copy that into an image using sload.f2fs. However, without an option to
preserve the owner user & group of files, some files end up being owned
by the wrong user / group (0:0), which causes all kinds of other issues

This patch adds an option -P to preserve the user and group of files.
---
  fsck/main.c       | 6 +++++-
  fsck/sload.c      | 5 +++++
  include/f2fs_fs.h | 1 +
  3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index a538c72..8438b45 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -132,6 +132,7 @@ void sload_usage()
  	MSG(0, "\nUsage: sload.f2fs [options] device\n");
  	MSG(0, "[options]:\n");
  	MSG(0, "  -C fs_config\n");
+	MSG(0, "  -P preserve owner user and group\n");
  	MSG(0, "  -f source directory [path of the source directory]\n");
  	MSG(0, "  -p product out directory\n");
  	MSG(0, "  -s file_contexts\n");
@@ -549,7 +550,7 @@ void f2fs_parse_options(int argc, char *argv[])
  #endif
  	} else if (!strcmp("sload.f2fs", prog)) {
  #ifdef WITH_SLOAD
-		const char *option_string = "cL:a:i:x:m:rC:d:f:p:s:St:T:V";
+		const char *option_string = "cL:a:i:x:m:rC:d:f:p:s:St:T:VP";
  #ifdef HAVE_LIBSELINUX
  		int max_nr_opt = (int)sizeof(c.seopt_file) /
  			sizeof(c.seopt_file[0]);
@@ -685,6 +686,9 @@ void f2fs_parse_options(int argc, char *argv[])
  			case 'V':
  				show_version(prog);
  				exit(0);
+			case 'P':
+				c.preserve_perms = 1;
+				break;
  			default:
  				err = EUNKNOWN_OPT;
  				break;
diff --git a/fsck/sload.c b/fsck/sload.c
index 4dea78b..6929023 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -187,6 +187,11 @@ static void set_inode_metadata(struct dentry *de)
  	else
  		de->mtime = c.fixed_time;

+	if (c.preserve_perms) {
+		de->uid = stat.st_uid;
+		de->gid = stat.st_gid;
+	}
+
  	set_perms_and_caps(de);
  }

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a51a359..cdcce2c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -505,6 +505,7 @@ struct f2fs_configuration {
  	struct selinux_opt seopt_file[8];
  	int nr_opt;
  #endif
+	int preserve_perms;

  	/* resize parameters */
  	int safe_resize;
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
