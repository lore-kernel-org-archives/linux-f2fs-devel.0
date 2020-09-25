Return-Path: <SRS0=8g9c=DC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D0C4363D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:38:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FB0206BE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fpVypGUO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NLA0t1wN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXZNV2sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FB0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLqk3-0006Mb-Iw; Fri, 25 Sep 2020 16:38:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kLqk2-0006MN-7H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 16:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=huhhpYFQZkddt/radLtgjMsLhiWVs7w1vEiI3gqnmaQ=; b=fpVypGUOBmJ6zpno2zEeuQBeoJ
 C0K/AMm1o14UYZ8ltt1eAlR9Pw8ynb1c7ZKdImFzuc63fMwCp9mfNBN2uQQLpeDt2kB2MaQP8aCqd
 AbRCaor8AjpjHF+RtkfYOuGn4Nl0XrYN7qDbUYH+5Pt6nvSNMb0JE9CWeTrUogwPrDtk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=huhhpYFQZkddt/radLtgjMsLhiWVs7w1vEiI3gqnmaQ=; b=NLA0t1wNByry8YTd8fAqoTYczc
 eDsrCI/jJrTW9wyJmMPDX6H2K+NZUqf/hZP73f41rokh/T3sH7yqX9MKHjx3eUII/ob8S3QSuCwte
 R2TNjRo5rQZztjw2mtQTbRW13xcxb47/Zm60SiSk+uhyBsBI3iANZNcW/P5s54kxqDZI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLqjq-005igw-ET
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 16:38:38 +0000
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4E52206BE;
 Fri, 25 Sep 2020 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601051901;
 bh=QGgqzYHKwLhU8qGchhG95ocnro20Uloj/gEjGanOpKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WXZNV2sUi/3rDC09k4sGxhoTano9Jr5dbiDuP626WoskNDGjMd0MRTKAnMKx4XQxz
 nIHpWb7E/D/qUUuw2r65VKRu9FEMgK2yAyy47ShyMUlLxmwtDf7Si917sgWXqYImby
 QLuYCTdxfodQirmxcyN15uEStZSRHx5K10lZ3IMk=
Date: Fri, 25 Sep 2020 09:38:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200925163819.GA3315208@gmail.com>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
X-Headers-End: 1kLqjq-005igw-ET
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
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
Cc: syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, glider@google.com, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
> Hi,
> 
> I don't see any problem here, thanks for your report. :)
> 
> Thanks,

What about if max_depth == 0 in __f2fs_find_entry()?  Then __f2fs_find_entry()
would return NULL without initializing *res_page.

A fix could be:

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 069f498af1e3..ceb4431b5669 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -357,16 +357,15 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 
+	*res_page = NULL;
+
 	if (f2fs_has_inline_dentry(dir)) {
-		*res_page = NULL;
 		de = f2fs_find_in_inline_dir(dir, fname, res_page);
 		goto out;
 	}
 
-	if (npages == 0) {
-		*res_page = NULL;
+	if (npages == 0)
 		goto out;
-	}
 
 	max_depth = F2FS_I(dir)->i_current_depth;
 	if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
@@ -377,7 +376,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		*res_page = NULL;
 		de = find_in_level(dir, level, fname, res_page);
 		if (de || IS_ERR(*res_page))
 			break;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
