Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E510BC77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  9 Apr 2023 05:30:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1plNcx-0004h4-VV;
	Sun, 09 Apr 2023 05:30:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wanghan1995315@gmail.com>) id 1plNcv-0004gy-Oc
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Apr 2023 05:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1yGdTXD81UK+6RB1Ag6uhuMGqDZmHdmvA9kSohgNfBs=; b=DHD/4Hn66NmM5hJqD9XAj8d440
 aisTroEsVrpTDXz1N2BTiHksP9IekmtutuPEdlnAQtV0j+BLOoZYV+SnUMiVQ8s1q3V1wH3CL5Ztx
 QccMYv9r5O37Ibw1sqAEtGYF9hHGw+hjcmOy8Wac4W7mhSDAeRPcVbrkHgDnUM+RF3hM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1yGdTXD81UK+6RB1Ag6uhuMGqDZmHdmvA9kSohgNfBs=; b=M
 MatzvQG1bSN7lFlwIkgllH5EpuaHlg0uS8rqadDqAFB5l2v8+6D84UXzH32AYq4VDGmSNIGwvVV18
 LArruw9BE/Fo05XIy6V19r5FrWBWA/3swnc124k0YvcmuPZTFVJPtJfJzQ1/6MEwqPXJMmrd8MBUl
 NlmMA9yElQswLKUA=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1plNcu-001mJP-VZ for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Apr 2023 05:30:10 +0000
Received: by mail-pj1-f48.google.com with SMTP id go23so4812884pjb.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 08 Apr 2023 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681018203;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1yGdTXD81UK+6RB1Ag6uhuMGqDZmHdmvA9kSohgNfBs=;
 b=WmqZj+7C9UJs/4Awm/8MxzqVnxLeJ0Uwk4dTwQCCBkPto6RdMcQmD6mMsfVddwYnki
 wwxrncMe1oEqNZa52XJg3esWFFuSJuscTvVDRGptjWxYbrTvopyK+V1cvJy/jspmo4Gl
 Nz5wcmv0dsplsVM570qACui//loBMlhdtSFA+5azLQDmAcjTWmFYhqGve4Irl9uigRHh
 i6XWa1G0ZNmxM/xXvY1YuNoDyXOJkA1MjasNAOp3hR4PBbRekHKyqxlN5j16z+Rg5DI6
 w4lYolN5cqP6Q8gaqX64nTt5s9H98NWDbgoFIU/+IO0KW/4GAvYRd6kOk3Ufh3h1BiiL
 VzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681018203;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1yGdTXD81UK+6RB1Ag6uhuMGqDZmHdmvA9kSohgNfBs=;
 b=eSQu0bNy/HM4Brleq9Rz1IwOoxer0MWO0lEKlX9XgoGMCNvwGop+LrH2+ThlYS9RWS
 lHnT8Ug0Ufce9bWFm1LJE/dEIC4HVy/ZYDNLsQCin30LNIW1QOCecKn7CNo2VejmvSnA
 DK+qILHCdJknDRwS8HMtn1eu3madl9jziF/ma5z1AoqrBG7Hubc94f/fBqMS0YAB4Kvi
 vcgt6PD6c9SFneqTYSVcHRRlODF46QNWVB0tSvPmcFajZEIM3A5+crFTNDhgESFpgR7Q
 DNm8/ilcJax/rrJ5dsH9F7TKBRZwLe6lQ4tW3IecmL973o8aFJQOBiI+hhCcaX+v+5by
 ZeRA==
X-Gm-Message-State: AAQBX9fQqO+deJtX3gzQlwDF3SDyY8yGdbIIdaYoVo2sSRxeJeS3o6nO
 XA0y2edsQQmCo12cfiZpI0k4H7c5okNhQo0eT/Y=
X-Google-Smtp-Source: AKy350b7tGXFDbHUydSvmDVXA/EJexOmDxAPr6/WRr3WRDXuPjUCXY1xuDX9tRtp6rzmCA9xhHOEES5tV7CWfpJe+sk=
X-Received: by 2002:a17:902:d48e:b0:1a5:e03:55b with SMTP id
 c14-20020a170902d48e00b001a50e03055bmr1027625plg.11.1681018203235; Sat, 08
 Apr 2023 22:30:03 -0700 (PDT)
MIME-Version: 1.0
From: Wang Han <wanghan1995315@gmail.com>
Date: Sun, 9 Apr 2023 13:29:51 +0800
Message-ID: <CAFfSv_0z9gmzj0GaUKNBq9Qt00F4f9diA5O_XXyaT8pJyrSmtw@mail.gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org
X-Headers-End: 1plNcu-001mJP-VZ
Subject: [f2fs-dev] [PATCH] docs: f2fs: Correct instruction to disable
 checkpoint
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This should be 'disable' rather than 'disabled'.

Reported-by: LoveSy <shana@zju.edu.cn>
Signed-off-by: Wang Han <wanghan1995315@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst
b/Documentation/filesystems/f2fs.rst
index 2055e72871fe6b..c57745375edbc7 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -264,7 +264,7 @@ checkpoint=%s[:%u[%]] Set to "disable" to turn off
checkpointing. Set to "enabl
  disabled, any unmounting or unexpected shutdowns will cause
  the filesystem contents to appear as they did when the
  filesystem was mounted with that option.
- While mounting with checkpoint=disabled, the filesystem must
+ While mounting with checkpoint=disable, the filesystem must
  run garbage collection to ensure that all available space can
  be used. If this takes too much time, the mount may return
  EAGAIN. You may optionally add a value to indicate how much
-- 
2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
