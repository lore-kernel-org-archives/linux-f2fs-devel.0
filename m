Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C466C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 05:32:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCwtU-0005WO-1D; Sun, 17 Jul 2022 05:32:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <fengnanchang@gmail.com>) id 1oCwtR-0005WH-Pm
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 05:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tzk0OdsnzbcvBwKxu7XPQEWS95T6VDWn/TH2lZTIbDo=; b=LIpH4N5v3JS+2FgHMY+Z791hqz
 YzZ5Kn9L4hQXPSjKFg/33kuJuS3q9UJ/ABPp+98WutNxuboZ6hr0j5pwE/6UtG5Wbad5eWdJsa6hj
 QtLFLrqc9iwaQg+J+tB82tV+2b10nPsfhc1G+WtXSVvhEpG1jnf+Iey3pG0R6xAhyf2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tzk0OdsnzbcvBwKxu7XPQEWS95T6VDWn/TH2lZTIbDo=; b=T
 X5lEsRv5gXobGkZZoLLt4g49Zxp2WdvbwQgiEaH5DQ3p921kTrEC+i/vykzviT0GN+maNDBxdkNF8
 5Q1uvPARy7iFS+62/uXqdtO8JCSswq00boi9R9NLsbywRvf2xFDULKYDpsfuJF4Gl5iNlMEjUZ/SQ
 4oUjxOyF7Tdxnvi0=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1oCwtO-001ZvJ-4Z
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 05:32:37 +0000
Received: by mail-pg1-f180.google.com with SMTP id 72so7959819pge.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 16 Jul 2022 22:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tzk0OdsnzbcvBwKxu7XPQEWS95T6VDWn/TH2lZTIbDo=;
 b=T3QeSrnmzmzdVYwLnx5tXBuprIE8EuctSOcSbE+IoaDgyYl3KldtM1CNdIzzPBudtS
 2NAPulod/pL4kDyJpcRzZaliLjlAxB0KupCuOWJSu+uJ5aevHG9R8ozQkp3/VrVR6web
 HJ06QdL0yCyQodORKF21AWYzJKzzB2+Sw0PHjFdn0gf46tOx5ftfY4AKKoTniKeSKtep
 kd0IWI1m8rWh60AVin2LgWhtNGjIzW3/NLTjzKIqBstLRmJoxT9csS69M3IfpAJECLfX
 rtBAzEFCnaI0ynIxcoHDGrqSZaiY4OG7uSupYRnZcq47ufnYY6CmlDwFN8Yi/QUkYJ9j
 bpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tzk0OdsnzbcvBwKxu7XPQEWS95T6VDWn/TH2lZTIbDo=;
 b=2hnr4I8X47qFXT+uHlGQGJsOtmQ4cXdNAgnH9RPvIEkd5wCakovnKlT1yk0LJxIGWT
 +y/4qTTHJ3Cq+el+iHE6+E7XBfHOuDJ5Oz2sm5y9flAbcwp8PSxWOiAh4tUR9CcupzIG
 K4OXxbGzFGMdF7rGtk56H+tFs+I3hB6Gk98d+Ym+yC4r9mCoeJs0ahjfCQ1yHFz2+I7Z
 9VrL8rQWub0ttqcTEI3zTB9+tFTPnH2mTN+k/Nb+J0CfmZ5cBmjN0e9hjiBi0eh0CEYj
 15unMLC38W4DnOeJNDm+hc4DrJ3kq/7GTneeJywTFdhHQFVXYp4jfVsDfcpsXYdE02KQ
 xfKA==
X-Gm-Message-State: AJIora89zz3iBpi2NbHkU/C0S8w7L3U61f7LZx5erEGPsAHAyXYF9qLJ
 jjx4TkFRQ0kSQUWM3JYdqxNxXyM83tk=
X-Google-Smtp-Source: AGRyM1sN4+Gk1VwV4jSPYFzwS4Ou9k+/1b4uAmjrsKi9vTM361UjzWsJ3WUyltbuem3pKn6pMfin7A==
X-Received: by 2002:a63:f910:0:b0:419:d6c0:c969 with SMTP id
 h16-20020a63f910000000b00419d6c0c969mr11195534pgi.624.1658035948594; 
 Sat, 16 Jul 2022 22:32:28 -0700 (PDT)
Received: from localhost.localdomain ([205.198.104.202])
 by smtp.googlemail.com with ESMTPSA id
 n8-20020a170902968800b0015e8d4eb1d3sm6488814plp.29.2022.07.16.22.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Jul 2022 22:32:27 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 17 Jul 2022 13:32:04 +0800
Message-Id: <20220717053207.192372-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oCwtO-001ZvJ-4Z
Subject: [f2fs-dev] [PATCH v3 0/3] support compressed file write/read
 amplifiction
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Fengnan Chang <changfengnan@vivo.com>

Optimise f2fs_write_cache_pages, and support compressed file write/read
amplifiction accounting.

Fengnan Chang (3):
  f2fs: intorduce f2fs_all_cluster_page_ready
  f2fs: use onstack pages instead of pvec
  f2fs: support compressed file write/read amplifiction

 fs/f2fs/compress.c | 21 +++++++++++++++------
 fs/f2fs/data.c     | 46 ++++++++++++++++++++++++++++++++--------------
 fs/f2fs/debug.c    |  7 +++++--
 fs/f2fs/f2fs.h     | 40 ++++++++++++++++++++++++++++++++++++++--
 4 files changed, 90 insertions(+), 24 deletions(-)

-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
