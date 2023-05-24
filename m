Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09415C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 May 2023 07:09:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1idA-0003dY-KJ;
	Wed, 24 May 2023 07:09:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <miklos@szeredi.hu>) id 1q1id0-0003dQ-IV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 May 2023 07:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MB0PkgtOYu2DAciIYbJ/doyhq3ZdSDKw62DeZCSSPtg=; b=Y8zW5vpvsySp1yOxIwtuPuTM6O
 h0nOanqLSmjS1R62hlCmrp7j2DAAf9DqYUEu/aUGvtXJScH32fpZdM5vuN+BjlVpN/W1FmTPYr1wM
 cAHFXPkhxS/odYzxdS8YWQ1UdX3fEEQUUmRwUT9LjBSzlLQ/ZlZGeZ/5khiCGktl3aEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MB0PkgtOYu2DAciIYbJ/doyhq3ZdSDKw62DeZCSSPtg=; b=VoWtf3r75WIHB3MJ4367T1WYHC
 11hhz76U5IOEksbxcDDiFqkYYSS1iwEtHOm5AHBt2m2mr7xvExrno43Kj0dVWucXOknezzsi8xk09
 IuS0WRA1dJF4r8UACgw0d5rpEJwGW8QLgNwiqcY2zVbh03PKec2c9veETP83MxlKGfwo=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q1ice-0006Qd-3k for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 May 2023 07:09:35 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-96fbc74fbf1so87346866b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 May 2023 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=szeredi.hu; s=google; t=1684912157; x=1687504157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MB0PkgtOYu2DAciIYbJ/doyhq3ZdSDKw62DeZCSSPtg=;
 b=FYCG0I0xG/KCzcPeRgfWGhFKBLQH8yo4Mb+b3h/3/MNGJYaOJxYFefWYzCbWzDOLJ5
 GslHMTl4heaZuqXTEmqMZYV3JWjK8Zt4w+vYkPylVmw2imfly3Tp8dcGkm97OVZ15gac
 hO02Kope0eh3dNS3sBBKR4sYeiW7mzVKy2JdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684912157; x=1687504157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MB0PkgtOYu2DAciIYbJ/doyhq3ZdSDKw62DeZCSSPtg=;
 b=bgZye6IVGCfT2Tgd/uV9HHfUots3oIjACirpqSmfryI7NSjPfE1pH7MoBbGrhwzN+S
 EysAxrOOqxvqi4MHDSmC163k0uxI/tzPAnMkRWLFmsGWRG3CYG8suLcfW3zlPbXxcxGU
 49h52lwW8h9CHAnFj7+GKAAhNLQLLCn0Goz1688JvijJfgl1gQw7DUM9u8qa4iuOa8Ud
 JyXNVNK6Ee5tx1v4/P4I4wIGsm7ml7X3bgloL3j2lLrQHaeIpKKb0K3pTV6TFk2Uhgax
 7MMDsCbWmX7q8yoOJEUxyfezeujGfO3gW1rOA+2HEDzkvWcosfc3Bk4OLV8L13c5Hnsn
 Mrqw==
X-Gm-Message-State: AC+VfDwK48cpUkrVk/reUuqY1jhpnk0brx7ETyPnc8tffz7pdkNhOGVH
 cqilZAxjMCK46Ygpg5mhbp0YnwNLsOmg8Lj9x/92Ag==
X-Google-Smtp-Source: ACHHUZ4OvyrYEQkEUfZSmUZD5S0dixYDveppalH3smz8YjXbgWTLCqDqGb6U6n7MopqEkuxUiQE5XNBE/E81YW5lpSg=
X-Received: by 2002:a17:907:60cc:b0:96a:580e:bf0f with SMTP id
 hv12-20020a17090760cc00b0096a580ebf0fmr18686933ejc.14.1684912157630; Wed, 24
 May 2023 00:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230524063810.1595778-1-hch@lst.de>
 <20230524063810.1595778-12-hch@lst.de>
In-Reply-To: <20230524063810.1595778-12-hch@lst.de>
Date: Wed, 24 May 2023 09:09:06 +0200
Message-ID: <CAJfpegtt2eD4Cw11f12cmcvHLe9VHhPLQdJWpwyAmeY-SrVuOA@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1q1ice-0006Qd-3k
Subject: Re: [f2fs-dev] [PATCH 11/11] fuse: drop redundant arguments to
 fuse_perform_write
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
From: Miklos Szeredi via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, 24 May 2023 at 08:38, Christoph Hellwig <hch@lst.de> wrote:
>
> pos is always equal to iocb->ki_pos, and mapping is always equal to
> iocb->ki_filp->f_mapping.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
