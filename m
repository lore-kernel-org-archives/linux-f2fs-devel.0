Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA33C46CD2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:55:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUw4p-0007CI-LN;
	Tue, 30 Jan 2024 21:55:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <msnitzer@redhat.com>) id 1rUw4o-0007CC-8D
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jan 2024 21:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtZBEe426KIf/mBUMlvvoaF7jyFEZ9/COBSE2/txMLU=; b=IgJSR6qcZKra87WyY3IvJPgRdb
 Albom0m5uZKgv53LXNy+7k6p1tUcFQ8k7dZTepq3vxrdN2Se2WY9rbqI5gtCFhcnZSRnKvYLnFMh1
 toRzFTID1KU5a5HgRfLXjgkBA1Jwfl3xV390YdyW7LJ4nRcxnWQyXe/mAbANiCyPS/JE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AtZBEe426KIf/mBUMlvvoaF7jyFEZ9/COBSE2/txMLU=; b=CyzClvQd3ppg+L13yQ6weDA+Es
 KwT85VOrhX1JAOX/AphMTMQ3v+LQMrOivRkaWkmZZKpPDJ1F60lZ1kCnKukss8KPQ0LQxhPAI6SJ0
 /7KNh6rzGeN0Qo9TVWHpDH/zj1sQ3G4zfzM3ii5rkr+yzCGXPNfbzysqnKarWYaf1A0k=;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rUw4k-00044V-A4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jan 2024 21:55:31 +0000
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1d91397bd22so7180955ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jan 2024 13:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706651716; x=1707256516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtZBEe426KIf/mBUMlvvoaF7jyFEZ9/COBSE2/txMLU=;
 b=DuZcaaHhhhFvXib+7tc5oa2bQY+QFuX9KMjR9QhEg/pIkGOneTBamsB4Ah8GDdMXx4
 Ov+6ovDXidvUpgyoCXWN4Q2cud/Vq90yOSyl654zqPi1NGTRcpvFpaUCzaoEZAA5wr00
 IDFMM3DuzwGVaqlfdSvfiE6JhLo/llZyfWIlzd2NHS0ch2GyI1gWZtzsprLEAgZ/pPBX
 AQTdb4VrxiVV4CL0x2hQ88+mctNPfoe7CGjNCHdTckU+fqEYDq7yUTPDqa2TfDL3KNMP
 U2v3fJUyOgpN2btR7IIUB++YqnHm6NoOdmdxFGkLHV1ILEKbW2MjOb1sFah+hM1KuZmz
 tFVw==
X-Gm-Message-State: AOJu0YxbsB+K6/W/dwkWrxfHOXW/aqZnSKk+4HBzPnrrLuuGtbYVUOOe
 P5RuL2cSXiJ0q2q89JsjQTBCV96J0Q3pZpZkqojDE5VG9R+2oehCk8xzEyNaGdoc1ugFPzm2YH6
 P1g==
X-Google-Smtp-Source: AGHT+IExCJjqhy5J/HQbLwc6HEIv1PKoKFV6opMfTc/hdwP/PWAAPv9RfvTcXLRcTuNHUUdlDE2mNw==
X-Received: by 2002:a05:6214:f2c:b0:681:7d81:705b with SMTP id
 iw12-20020a0562140f2c00b006817d81705bmr615439qvb.4.1706647763522; 
 Tue, 30 Jan 2024 12:49:23 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net.
 [68.160.141.91]) by smtp.gmail.com with ESMTPSA id
 of10-20020a056214434a00b0068c560eaf8fsm1688182qvb.134.2024.01.30.12.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 12:49:23 -0800 (PST)
Date: Tue, 30 Jan 2024 15:49:22 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Message-ID: <Zblg0qE25wPt-SRv@redhat.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
X-Headers-End: 1rUw4k-00044V-A4
Subject: Re: [f2fs-dev] [PATCH v3 5/5] block: remove gfp_flags from
 blkdev_zone_mgmt
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
Cc: Naohiro Aota <naohiro.aota@wdc.com>, dm-devel@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
 Damien Le Moal <dlemoal@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Johannes Thumshirn <jth@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 29 2024 at  2:52P -0500,
Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:

> Now that all callers pass in GFP_KERNEL to blkdev_zone_mgmt() and use
> memalloc_no{io,fs}_{save,restore}() to define the allocation scope, we can
> drop the gfp_mask parameter from blkdev_zone_mgmt() as well as
> blkdev_zone_reset_all() and blkdev_zone_reset_all_emulated().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
