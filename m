Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AA4C88E7B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/WQ3ANhOerm+gaKWJdNGdgYOOc5a8TLL/FrbJ7BrweE=; b=HE7fnVLAKPbbEAnLg8Vx6xrWb2
	Hl5gCzZjpwSyvyCB/yFFjNi+Hme+VDmdRueDUR7wT5pl+hSPYn9jrklmqWXZhP/3jH46QF3RxJdr/
	BosRa1FvwyAbEKBTZ++iZ3VtkKC1suIzPWTSa08wFh2DFR9ldRmxS6M6FZX6V7UueMF8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6Ke6-00050X-Vn;
	Tue, 15 Sep 2026 04:19:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x6Ke5-00050I-KQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 04:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YX+HIknL8n6VZjreq5xGVkE9hGJLekLhtxm24ds5FmA=; b=AWVRyVQTgB4NTL3DeJWklLAo/p
 hLjoalkpXHvjBOG7QigQsptJnqKrccFar1m2kQWq2vaT9E57pgsToDTqovDC4dqF7wfaogbBCNXFN
 lg5Kv4Allea2PxQx2YR5x9uq9RA97MgcvylkGznEI3D/FFvzG5Hrcyi+dW6iC9ERD0MQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YX+HIknL8n6VZjreq5xGVkE9hGJLekLhtxm24ds5FmA=; b=Z
 9u+9AAA9b/9OX/HILLcrhXK6zwKj6Jdx8Cwyi597tEPZnenoIa8y2wqQz9Ck40SYXb41YI/4b4REm
 /EfGoat6uKCKmzlu1G5UjL5Ce05hWT7yeCQy15/+W1Bls2h4wpl+SiXhhnKHLI2vurElzOVj3WXzo
 oHN1iIpO2NMxeagI=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6Ke4-0001Wc-8e for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 04:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YX
 +HIknL8n6VZjreq5xGVkE9hGJLekLhtxm24ds5FmA=; b=AesrpVbKW0Q7/KU31Z
 uQEkuU+S+OPxt19HBB4hruCxNjjChl4a1fPe+tVJ/RVGw0wLWc+veJSvwWyqeiIG
 j07T/SLxNDYQ4X+kjCen6n4UszSLhDJYOwXn+75lI0lbzt6/XeVONGzkfZbNgjq8
 vyjnDxfXSgTPqEVkTC+uRwUgs=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgDXreo9x6hq3jBvHw--.36918S2;
 Tue, 15 Sep 2026 12:19:10 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 15 Sep 2026 12:18:55 +0800
Message-ID: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: PikvCgDXreo9x6hq3jBvHw--.36918S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxur15WrW5JF13WrWDCFg_yoW8ZF43pF
 Z0krZ5GryfCr47ZrZxAF4Fqrn5t395W34UZ3WxXry2qF98WF1ruF1kt3W8WF4xJryfJw4r
 Aa1UAry8WF4rAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCoGdUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsB-FlWqoxz8XsgAA3g
X-Headers-End: 1x6Ke4-0001Wc-8e
Subject: [f2fs-dev] [PATCH v2 00/14] f2fs: support & optimize large folios
 for writable files
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series supports large folios for most readable/writable files
in buffered I/O paths, including normal files, block-layer encrypted
files, and atomic files except for inline-data files, compressed files,
and quota files.

It also extends f2fs_folio_state to coexist with f2fs page-private
flags and to handle large folio write path and partial truncate of
large folios correctly.

Benchmark details can be found in the RFC v2 cover letter [1].

[1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com

Changes in v2:
- Addressed most of Chao's and Daeho's review comments.
- Updated docs for compress policy with large folios.
- Link to v1: https://lore.kernel.org/r/20260826082641.2007658-1-zhaonanzhe@xiaomi.com

Many thanks to Chao and Daeho for your extensive reviews and valuable
suggestions!

Nanzhe Zhao (14):
  f2fs: extend folio state for large folio write path
  f2fs: carry subpage offset and count in write IO
  f2fs: support regular file buffered writes on large folios
  f2fs: support atomic file large folios buffered write
  f2fs: support large folio writeback
  f2fs: prepare mmap write faults for large folios
  f2fs: make GC migration large-folio aware
  f2fs: optimize small block size large folio read
  f2fs: support partial uptodate large folio read
  f2fs: handle partial truncate of large folio dirty subpages
  f2fs: fix zeroing paths for large folios
  f2fs: handle block cloning within the same large folio
  f2fs: allow large folio support to writeable files
  f2fs: make compressed files compatible with large folio

 Documentation/filesystems/f2fs.rst |   10 +
 fs/f2fs/checkpoint.c               |    2 +
 fs/f2fs/compress.c                 |    3 +
 fs/f2fs/data.c                     | 1221 +++++++++++++++++++++++++---
 fs/f2fs/f2fs.h                     |  105 ++-
 fs/f2fs/file.c                     |  229 ++++--
 fs/f2fs/gc.c                       |   32 +-
 fs/f2fs/inline.c                   |    7 +
 fs/f2fs/inode.c                    |    4 +-
 fs/f2fs/namei.c                    |    1 +
 fs/f2fs/node.c                     |    2 +
 fs/f2fs/segment.c                  |    6 +-
 12 files changed, 1404 insertions(+), 218 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
