Return-Path: <SRS0=Qhk5=7L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56408C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 14:40:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2421B2072D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 14:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ekL5Lv36";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KGhS/EQ9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eE5upXYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2421B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jegB8-0002QK-OJ; Fri, 29 May 2020 14:40:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <axboe@kernel.dk>) id 1jegB6-0002QC-Gy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 14:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sstDEw2eR7/x5s00uzGBoVK1nqE9b65b7cAMAqhOjao=; b=ekL5Lv36nNSdU1QZs0QtoV3pui
 MagsXMd5unwZAo6UzNRZkxREhC9C0by8Yrq2BvwSt9ndFYVLU+wTSX+wlg60ZRvT4+sPfmvPovVCQ
 am6v8uP8//Dep8a9v/IKnf19ZeGSeg50e/8RidyKKIH2Es64dP8xxC1AUE78s+54cXwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sstDEw2eR7/x5s00uzGBoVK1nqE9b65b7cAMAqhOjao=; b=KGhS/EQ9+lfuHZffcCYbcOAvnf
 5CLCsL5ne2wzmUwbyWBz91HssEnnxVoQQ6JK+IeJNo67Z5LQKib/kK5GwxAAwHWSi2q4SbkkRYYHn
 jAUWWIOjuKHzz1cTGuj7dJbV1vCMDTNnwxXTjiThx3C3QYMFmNCX7Kj30XddUB9qs/nM=;
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jegB4-00HN2N-Jx
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 14:40:08 +0000
Received: by mail-oi1-f196.google.com with SMTP id j145so2745857oib.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 May 2020 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sstDEw2eR7/x5s00uzGBoVK1nqE9b65b7cAMAqhOjao=;
 b=eE5upXYzk0pow1GTjkztlADM6NfVbrh/uHt+G1jl9EulITHptpOGivfgZ9UM2DZPeT
 QzDSBImSr62zvHA4fpZjPKoOgIad9kZyPX2Pg/8nuAQTJ3/2yu1dOc5WcOu99Kko/uk+
 JHHjcQeYVXofPi/9w67mwpp7taL/v8rnEtFjiUQt2+5HJT1HNIqLVfzk8C15zK0dRQDM
 HprQkgIl0QIfcdgkulZv6c2+BpjhhJc39zy3lRejrUhTw58N+xFCRBzYs65EUgEZZaQb
 C23jReqIIypb479CHVfyFfIhwVVplo1+96n+FWZRlsJS/ZWLbHO247w+VeMKyAtOGXp+
 Nwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sstDEw2eR7/x5s00uzGBoVK1nqE9b65b7cAMAqhOjao=;
 b=dqNyJAow3L9AwOynIDk1+OW3+BDKoirfWo+a9NbgWo8GFLswxFsacEQdojuL14wemb
 tIrFhb1s43sMGBLH5F+gJnzZi+hWdhNzRkICypzFyXbOC/iTVgLW8+dc2IVJiLwaWkdn
 HSMfAYWm8AOmc8NVGYZiZLOOJBFEhMYFbx/jcj5mopU655JTCPCEuquJ0mYaxfu6KwJK
 JPSeO76sOylOqNJRYkH9fmuuQri+3igAZ5CPy/YV6Y0+sOxJl4ZZhwvYccQNZ/GAQEY6
 5XbQuxWYLC4FsouBsY58fHX6eINdrTc2cJcL+6Qhc0Qbebp2UFHhi4uPaK9njnH6llj0
 3wnQ==
X-Gm-Message-State: AOAM531YQVcYsP+d9Am8g2aaE5kEk6EHpIoLucBlqGgXNf9y4ou1wDbi
 oZ+suUCOUFcjZudx0aId1mbr5wA1Ebu0DNae
X-Google-Smtp-Source: ABdhPJx/vZKTQwjkEYDfjCmjXR8SsS9x7O54I1G0OhUxjA27obWAm6HjQIWQQc+C6Ua+WQEtGiJQ1Q==
X-Received: by 2002:a17:90a:bf18:: with SMTP id
 c24mr9827989pjs.171.1590761617982; 
 Fri, 29 May 2020 07:13:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id d2sm6688603pgp.56.2020.05.29.07.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 07:13:37 -0700 (PDT)
To: Kaitao Cheng <pilgrimtao@gmail.com>, hch@lst.de, sth@linux.ibm.com,
 viro@zeniv.linux.org.uk, clm@fb.com, jaegeuk@kernel.org, hch@infradead.org,
 mark@fasheh.com, dhowells@redhat.com, balbi@kernel.org
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
Date: Fri, 29 May 2020 08:13:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529141100.37519-1-pilgrimtao@gmail.com>
Content-Language: en-US
X-Headers-End: 1jegB4-00HN2N-Jx
Subject: Re: [f2fs-dev] [PATCH v2] blkdev: Replace blksize_bits() with
 ilog2()
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
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, joseph.qi@linux.alibaba.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, linux-s390@vger.kernel.org,
 bvanassche@acm.org, darrick.wong@oracle.com, chaitanya.kulkarni@wdc.com,
 satyat@google.com, borntraeger@de.ibm.com, gor@linux.ibm.com,
 josef@toxicpanda.com, ming.lei@redhat.com, jlbec@evilplan.org,
 songmuchun@bytedance.com, dsterba@suse.com, sagi@grimberg.me,
 damien.lemoal@wdc.com, martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 asml.silence@gmail.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/20 8:11 AM, Kaitao Cheng wrote:
> There is a function named ilog2() exist which can replace blksize.
> The generated code will be shorter and more efficient on some
> architecture, such as arm64. And ilog2() can be optimized according
> to different architecture.

When you posted this last time, I said:

"I like the simplification, but do you have any results to back up
 that claim? Is the generated code shorter? Runs faster?"

which you handily ignored, yet sending out a new version. I'm not
going to apply this without justification, your commit message is
handwavy at best.

-- 
Jens Axboe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
