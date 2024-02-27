Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FD2C5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:44:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rezd8-0002Vi-Ih;
	Tue, 27 Feb 2024 15:44:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dan.carpenter@linaro.org>) id 1rezd6-0002VX-BX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Feb 2024 15:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZyqE6zwCtj8FzE3kFECe+lH0t4NfDfRRhI6K5GNDTGk=; b=lPej2YcKlaHB1D+5vzxbRlvVKM
 nmoY39LHj7AAmGoIsjdpA8Ul/0uj8i4JH+3rDYODr2ZQAFA2dkdR+HiylbPzP/kaQpfNN7AVDXVP5
 qSfhvpgOIeIQJzHyMypKcfWdx3u5UFjBthoQZIkcxBPZW8e/JYt36MxZMWJFW4tq/R7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZyqE6zwCtj8FzE3kFECe+lH0t4NfDfRRhI6K5GNDTGk=; b=V
 5B1swRaLAawMLfVNOfI+0/DP3LOs8R6fwd4IQDPFqj+34pah2dQ6bXYTya+TMFlMN66JgFU1DzBMQ
 By34ru9LPQF4aB6IQbJJKgHzuGVPbLLT1TOcCHNJckRH7kVrRvMAAqmTmJMEmIM8QcqjQmCVTTtYS
 a20wWtCx5VHSbwxQ=;
Received: from mail-lf1-f54.google.com ([209.85.167.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rezd4-0000mN-O7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Feb 2024 15:44:28 +0000
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-513143d3c42so574193e87.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Feb 2024 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709048655; x=1709653455; darn=lists.sourceforge.net;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyqE6zwCtj8FzE3kFECe+lH0t4NfDfRRhI6K5GNDTGk=;
 b=Rm2QfKZuab/xPl3Mz9nxF6LOvyCsB+KF4Qs/I/1zrG2gybV4bXQBzQKgj34tdM7Ldj
 VvrOK2dORWQnLY2ZiTrhQd4ug5rl94qMb6mFspDCCdFFj6g2xJZlI1dQTuGOwWP7RpEX
 UKe6gJ2ISvTYnaLaTJC+QKHRb8wIvXcbaSPpdr5vAEsBuWUTfkr+TGeVXf7NUqlTQgvI
 LFOUPWhVzoaZlCssq4glwhBVEhwdvnXvcdGWo1K6y+SW7NTslRaewmPmyPADvJj6qM2a
 v8zKtfI+Ontvxe5dv6o0cJROJvhKCfmR8kJrBTbf2eS1e0290Hue2OGgKI2zZoeAZa/o
 8vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709048655; x=1709653455;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyqE6zwCtj8FzE3kFECe+lH0t4NfDfRRhI6K5GNDTGk=;
 b=uQuy2QBaCASLFSJXU0vou5SFQkjhB9GlFsQ+qLX9JxUSq1FSohZ07EBsVTLqbLEq1j
 x+2bH3inNNJ/gNV+sHAW2Rv7VAGTz+CPArSIBPzL+EqAz8rz3rBYBIN8RfQcneF6YmzP
 vpKbHbcxzaabpx6bHatRZ0Woy0lP/Kl7NZVefKMs0T3sXRREjddy1jvVmK5KS4/7+RUN
 NfaE1/58M5moikQixz0Xm7ukd1sX3yGz45+wwR5SyZEeNnPWGKTwkgW9Vtcq+pLuHmgq
 Hs1Ryg1caWzoWillcBebbjJGavJzULrVUkqMqF+T7VNHqFAN+6tXcS2d3AwX+4G5/TNn
 NdwQ==
X-Gm-Message-State: AOJu0Yw9/QqDI/ylb4MVOPF7YD/xuX0qjlj+nsukPjQqUjMTfub4YJ4f
 1bzPdXV4HNMPIWHtbyYhLjW7iFTGOj+lu98zAYa2BLIdBPJ5Z+b/qQguiScwX1nTcrxkf6C4I8b
 P
X-Google-Smtp-Source: AGHT+IHpOljzyI6wZRjt/bF4pe+eAjXy2H2+2MDNzIGlbLNPAvf4LjiPK+b2T1eG3ClKkUIs6HLxMA==
X-Received: by 2002:a05:600c:45cd:b0:412:7b4d:b256 with SMTP id
 s13-20020a05600c45cd00b004127b4db256mr7458967wmo.18.1709047333146; 
 Tue, 27 Feb 2024 07:22:13 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 c23-20020a7bc857000000b004128f1ace2asm15108530wml.19.2024.02.27.07.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 07:22:12 -0800 (PST)
Date: Tue, 27 Feb 2024 18:22:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jaegeuk@kernel.org
Message-ID: <0dbca927-9037-4ccd-ac1e-98ade64a2a0b@moroto.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1rezd4-0000mN-O7
Subject: [f2fs-dev] [bug report] f2fs: use BLKS_PER_SEG, BLKS_PER_SEC,
 and SEGS_PER_SEC
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello Jaegeuk Kim,

The patch 9c1d3cd4ff8c: "f2fs: use BLKS_PER_SEG, BLKS_PER_SEC, and
SEGS_PER_SEC" from Feb 6, 2024 (linux-next), leads to the following
Smatch static checker warning:

	fs/f2fs/gc.c:2092 update_fs_metadata()
	warn: cast after binop

fs/f2fs/gc.c
    2089 static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
    2090 {
    2091         int segs = secs * SEGS_PER_SEC(sbi);
--> 2092         long long blks = (long long)(segs << sbi->log_blocks_per_seg);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Originally this was something like:

	long long blks = (long long)segs << sbi->log_blocks_per_seg;

So the cast seemed necessary to avoid an integer overflow.

    2093         long long user_block_count =
    2094                                 le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
    2095 
    2096         SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
    2097         MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;

regards,
dan carpenter


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
