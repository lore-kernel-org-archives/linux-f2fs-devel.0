Return-Path: <SRS0=w1ru=CT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B4C43461
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:03:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B2F22204;
	Thu, 10 Sep 2020 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YY+kuuDq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hvYH8Nvd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y40bQZ40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B2F22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kGNAD-00086g-P5; Thu, 10 Sep 2020 14:03:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kGNAC-00086C-LR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Sep 2020 14:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o+/vl7lnf46ejnt9iCPRjjv8/F+QwohauT1YcgB+GgY=; b=YY+kuuDqYrmGO+o8SRf67xMLGu
 WdovUHuzzCigi7u/QUGMs87nIplGnHcJsQuGyyLiPoXGv0IU7gIWlc5Y3Gzub0DneHjhIen9TaU8w
 SyUgPSAYyh1vwTnFMQDk2JZy5oWswEFwSvHEosairROVmroh21z5xJIoBe8cZR0PgApo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o+/vl7lnf46ejnt9iCPRjjv8/F+QwohauT1YcgB+GgY=; b=h
 vYH8NvdTz9TfZTcnDyIv3kh5G+zeggTiOn5lv/0giJA1qw1OKJnsnuj8aD7x83frnx90PnVoOmhkj
 pa6cVlZBD/JdEGNaBZ8NVLfgnJoKNk6XPR9NPMI+YU6mxWjUuPjeT5nA8Mw2Br7N8aO8Gg3Ny1psj
 +wSklMVa3wCeGIHA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kGNA4-0021ar-98
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Sep 2020 14:03:00 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8378221F1;
 Thu, 10 Sep 2020 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599746561;
 bh=r5CcSmnxz9R5t91tIgmwzv7faYaArtgahnyKSQWc5hw=;
 h=Date:From:To:Cc:Subject:From;
 b=Y40bQZ401rDeUT0ggae3yuJXfwdjFn/QCdxjv+EnvnjeP2wMMjvCocV9gEsiqx8Li
 7jiGyjdw4POeDoNJhWtPSQCGLhWaG4irLqegmi+yfJ14VUWxlc+1n4iBQAGUpharLl
 +yH8d+nJPaDo+jvvva5htc2M+C+7YXx1WnD3gEAg=
Date: Thu, 10 Sep 2020 07:02:41 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20200910140241.GA487602@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1kGNA4-0021ar-98
Subject: [f2fs-dev] [GIT PULL] small bug fixes for 5.9
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Linus,

Could you please consider this pull reqeuest having some critical bug fixes?

Thanks,

The following changes since commit 34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8:

  Merge tag 'linux-kselftest-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2020-09-08 11:56:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.9-rc5

for you to fetch changes up to 20d0a107fb35f37578b919f62bd474d6d358d579:

  f2fs: Return EOF on unaligned end of file DIO read (2020-09-08 20:31:33 -0700)

----------------------------------------------------------------
f2fs-for-5.9-rc5

This introduces some bug fixes including 1) SMR drive fix, 2) infinite loop
when building free node ids, 3) EOF at DIO read.

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      f2fs: Return EOF on unaligned end of file DIO read

Sahitya Tummala (1):
      f2fs: fix indefinite loop scanning for free nid

Shin'ichiro Kawasaki (1):
      f2fs: Fix type of section block count variables

 fs/f2fs/data.c    | 3 +++
 fs/f2fs/node.c    | 3 +++
 fs/f2fs/segment.c | 8 ++++----
 3 files changed, 10 insertions(+), 4 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
