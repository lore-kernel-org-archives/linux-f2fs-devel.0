Return-Path: <SRS0=v3Bs=UY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C79C48BD4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:56:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857A720659;
	Tue, 25 Jun 2019 07:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Wi79jrs+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ArYv0EKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857A720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfgJC-0003ue-R5; Tue, 25 Jun 2019 07:56:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hfgJA-0003u1-KM
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Jun 2019 07:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7QxID8fNGW6n9kiIwQwKyOc/MdT7eQo2az12BOj+qns=; b=Wi79jrs+94OcngHyIQ042xVHqj
 Ha7zsUpnlVXI5I/9ROgXkE46f0Tedi0IE/gHVcZptsvJjG6YtsmWzP1SKxRMpEO0PhlMYi9bjhOmO
 qSBTDwvH1754awQm4f+u7V/kDqwNZ2kVj+QgOSzdgsr0+yNaDlVJKUBQIuh1CTzOhJFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7QxID8fNGW6n9kiIwQwKyOc/MdT7eQo2az12BOj+qns=; b=ArYv0EKQhUsCp3t1+nxE8twovM
 JUYGBK0TNraf/ip57XLnVAGXy8qo1N6vt6Wm+aCebhUt0Br1kVf1yAOZcY72V0Bl8eegqp44p5Vwv
 Z26ZRAGqv8p2MBKowJUmjK4pqvEmn7+aiCMWYBTUcqLC+f0PADCy8Hh97rqq5ctIHXMQ=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfgJH-00D9x4-1l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Jun 2019 07:56:14 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3AEB77001CAEBEF3AD3F;
 Tue, 25 Jun 2019 15:56:03 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun
 2019 15:55:58 +0800
To: Eric Biggers <ebiggers@kernel.org>, <linux-fscrypt@vger.kernel.org>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-17-ebiggers@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <90495fb1-72eb-ca42-8457-ef8e969eda51@huawei.com>
Date: Tue, 25 Jun 2019 15:55:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620205043.64350-17-ebiggers@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hfgJH-00D9x4-1l
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
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Eric,

On 2019/6/21 4:50, Eric Biggers wrote:
> +static int f2fs_begin_enable_verity(struct file *filp)
> +{
> +	struct inode *inode = file_inode(filp);
> +	int err;
> +

I think we'd better add condition here (under inode lock) to disallow enabling
verity on atomic/volatile inode, as we may fail to write merkle tree data due to
atomic/volatile inode's special writeback method.

> +	err = f2fs_convert_inline_inode(inode);
> +	if (err)
> +		return err;
> +
> +	err = dquot_initialize(inode);
> +	if (err)
> +		return err;

We can get rid of dquot_initialize() here, since f2fs_file_open() ->
dquot_file_open() should has initialized quota entry previously, right?

Thanks,

> +
> +	set_inode_flag(inode, FI_VERITY_IN_PROGRESS);
> +	return 0;
> +}
> +


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
