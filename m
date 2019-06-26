Return-Path: <SRS0=M3qu=UZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C791CC48BD3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:21:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956A121726;
	Wed, 26 Jun 2019 18:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YeDca3Gb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="O5ZEnOR+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuI1lc8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956A121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hgCY9-0005W9-TD; Wed, 26 Jun 2019 18:21:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hgCY8-0005W0-98
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jun 2019 18:21:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SJg9Z8lr7+qHsmp1IM9Y+LJIE+gVqdIJrj7R3BQcgOA=; b=YeDca3GbLjUospGgLVD6Gtn/Ej
 eWjqETr6wWNWuhUh7oNsvRkUb3ffq+JSY3g0mnM3r58eWs/wG0dBdKha5WRYolH8rmfdKeuoAA0oG
 F6QT6yCKucgYjLGpjEdL1LjA4P222xgTDYq0F1jiEPCO2Z1p3cJayNhgSon3tr7GzBUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SJg9Z8lr7+qHsmp1IM9Y+LJIE+gVqdIJrj7R3BQcgOA=; b=O5ZEnOR+UWKPEahQvgO8sOm9bl
 ae+SeUbezOrRdSz71nB0ylGKTvzmJZ5lPll7u4btksUOCLc4Z0Tg+CLoP+Wib4Wb0wfDu0ep47euQ
 AVNL0FldKUKDYoEWD59K8oFcKlQAzrusSLV+WihNYNREDm4xygf5PlJWiZ9Me32JxqEY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hgCYF-00Ekmg-9h
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jun 2019 18:21:49 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07DA221726;
 Wed, 26 Jun 2019 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561573301;
 bh=pNDy9ibt9Htg2aMIkROB6dLLyxI5mmHvZKejgIZn7Oc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TuI1lc8jAO4MB0RfvPP/3xjShwRJ5zX3E3hM3QnXjDNiYK2hkpbKcuEqrrq4t9f3Y
 HFbcTFROptxFb6vvrHInrM7dcrlL86yIu0vDiQ9n7kCmvyRn/xKjMfwDx6VqIJcthL
 KS8lIu7/J75DGlTa501xa6kZdnbnaUIMVJWVth/M=
Date: Wed, 26 Jun 2019 11:21:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190626182138.GA30296@gmail.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-17-ebiggers@kernel.org>
 <90495fb1-72eb-ca42-8457-ef8e969eda51@huawei.com>
 <20190625175225.GC81914@gmail.com>
 <68c5a15f-f6a8-75e2-b485-0f1b51471995@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68c5a15f-f6a8-75e2-b485-0f1b51471995@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hgCYF-00Ekmg-9h
Subject: Re: [f2fs-dev] [PATCH v5 16/16] f2fs: add fs-verity support
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-integrity@vger.kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 26, 2019 at 03:34:35PM +0800, Chao Yu wrote:
> >>> +	err = f2fs_convert_inline_inode(inode);
> >>> +	if (err)
> >>> +		return err;
> >>> +
> >>> +	err = dquot_initialize(inode);
> >>> +	if (err)
> >>> +		return err;
> >>
> >> We can get rid of dquot_initialize() here, since f2fs_file_open() ->
> >> dquot_file_open() should has initialized quota entry previously, right?
> > 
> > We still need it because dquot_file_open() only calls dquot_initialize() if the
> > file is being opened for writing.  But here the file descriptor is readonly.
> > I'll add a comment explaining this here and in the ext4 equivalent.
> 
> Ah, you're right.
> 
> f2fs_convert_inline_inode() may grab one more block during conversion, so we
> need to call dquot_initialize() before inline conversion?
> 
> Thanks,
> 

Good point.  I'll fix that here and in ext4.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
