Return-Path: <SRS0=Ksgo=FM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F83C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 08:15:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EB423A51
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 08:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EB423A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmY9F-0003vD-Op; Tue, 08 Dec 2020 08:15:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <robinh3123@gmail.com>) id 1kmY9C-0003uv-AU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 08:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=; b=ZOFAbxK/1jYuREY+t1O6NcP/Iu
 4FD76FzmGHb68BRonfRzaa0dCR8yaq3DjHLNC0d0p6oJxydk2LJviIJq0RDJ+VcbjJAMezgnI7EuC
 Dv8RCIRjPh4k1nSgL7Mnv4HhJH2qzl9YNlsJmK5LOC5RW2xPaYYKjvR1ioDjDgWSJn5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=; b=h
 PgkWn6PDitRmh74DeXixGUOtOYNtp+GS1uX3WRf9i7LJCpC2EzFSlGNhiSOBzq3FgqRj0MEVJGFuw
 fLfSC7lzSWrlreQ48JH4N/n8EMXkHA7yfTSenklgCkSTbVv3K0xZ9Q5p9ONo8ZVmJhlmdw6vGGw29
 gorptWRo0iz8zlc4=;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kmY8z-006JCk-6j
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 08:14:56 +0000
Received: by mail-pf1-f180.google.com with SMTP id w6so13194907pfu.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Dec 2020 00:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=;
 b=XplbGEVMkw49ATGj0X5s2zGBOZ4Law2VvqzRfG2IzcCND6tnlpL9MisVk3WH/AJO2F
 +dXdWMjXhEysVTatNrp1YDGXNy1m7qxvUj7p3Uuv95atsnPQy6d3216A4mntr1eLyVPm
 hsaaXSHez8W8K3wtQZ/kWxOX0PlwhaaaciQpQHNJIWKEACUuziWdd/KrHQyn6YhRiU3c
 n/5mqBUaZ/EfzKKxKQf2mpXbvbpx825jQd3fogEMiR6/ibmZU4oQqVDvg9F8vlczmaFQ
 L7jipQneYO134IPROf3y6TTjvdba0harss/GQKgo+N5aZ/DilyRZGvr90ZsMduGBEuDM
 Qh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=doyuajGDAoaPFhb2ThVHLJXkkRiThGYIceTU9U28wvo=;
 b=U0/qugE8RAFpQziC8uXwBA5fJTf4mXab2IQXLuQCQTIL+/uCjijXntNWvUpryEBYI3
 +lvix3cGCSZNUSWhPsaK3eKbaiLd4iqV2VlIj6o8WAgSn2gVwTOLvjNOdFQZze/ZP1hb
 3u+k2fqurGbXqUQOXRFvvuL15NzaHJkcqVmUnshDN/JKcE7A1iKHYld3VtrkRHXeqk7W
 XNr1X2RxOGjDQYfNhT9qGwJe89BLYaqYhO5iG/olSvnuuNiAxmtHUlC8Xh33ctRsdzR2
 R50XAnFA72qqoFzYJS8AGqpSRDhcT9QdfWo6m3Z/Yq4okJrr/9Px7B8JPA59K7nwH2lD
 6wbg==
X-Gm-Message-State: AOAM532CPTjQKCXSyn7gtrGArAItxngb5OOgp64qMWLZcFydICkOeZpy
 ypVb/0a6PFZMJO4ilKrdpPOWf/T+ZsM=
X-Google-Smtp-Source: ABdhPJw0w/qfucPI9qD2kNAbfwIDKVlACeVmCEPvGem828ZlHRxCWhDk4BOJH4lJJFMyFymrQywmzg==
X-Received: by 2002:a63:da03:: with SMTP id c3mr21821637pgh.133.1607415279406; 
 Tue, 08 Dec 2020 00:14:39 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com
 ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 by smtp.gmail.com with ESMTPSA id 19sm2665387pfu.85.2020.12.08.00.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:14:38 -0800 (PST)
From: Robin Hsu <robinh3123@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org
Date: Tue,  8 Dec 2020 16:13:41 +0800
Message-Id: <20201208081344.652430-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
X-Headers-End: 1kmY8z-006JCk-6j
Subject: [f2fs-dev] [PATCH v3 0/3] f2fs-tools: sload compression support
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Robin Hsu <robinhsu@google.com>

* 3 patch set:
  #1: added some #ifdef for easier support
  #2: main code change
  #3: automake changes

v2 fix (from v1): fixed a bug and a more elegant error handling flow.
v3 fix (from v2): ./configure (automake) automatically determine to
compile in lzo and/or lz4 compression support depending on the presence
of liblzo2-dev and/or liblz4-dev

Robin Hsu (3):
  f2fs-tools: Added #ifdef WITH_func
  f2fs-tools:sload.f2fs compression support
  f2fs-tools:sload.f2fs compress: Fixed automake

 configure.ac            |  12 +++
 fsck/Makefile.am        |   9 +-
 fsck/compress_wrapper.c | 102 ++++++++++++++++++++
 fsck/compress_wrapper.h |  22 +++++
 fsck/fsck.h             |  15 +++
 fsck/main.c             | 157 ++++++++++++++++++++++++++++++-
 fsck/segment.c          | 202 +++++++++++++++++++++++++++++++++++++---
 fsck/sload.c            |  67 +++++++++++++
 include/f2fs_fs.h       |  76 ++++++++++++++-
 lib/libf2fs_io.c        |  33 +++++++
 10 files changed, 678 insertions(+), 17 deletions(-)
 create mode 100644 fsck/compress_wrapper.c
 create mode 100644 fsck/compress_wrapper.h

-- 
2.29.2.576.ga3fc446d84-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
