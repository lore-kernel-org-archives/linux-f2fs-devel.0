Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06E6C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Oct 2022 14:23:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ogoFm-0005ew-0d;
	Fri, 07 Oct 2022 14:23:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1ogoFj-0005ek-LY
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Oct 2022 14:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2fM88JkR3ZA5dJ8+EnLpWg95xXbRsFNcDjLXwrdZGhA=; b=iA8NcNw8zKlQvsvH3s6wk/Vr2o
 fwxMMVLU/Z5+ZovCfv4lsvw6QUsILOhxGlmEgD9SvFRa3tDFr+2dL3U2oUQqyKYxw16AtvTHqd2h4
 j+T70Gc+UDilHc8FDUmcV2TouyXdQtkYLbA3Qjw9olyArx5JiP0EZVpt2aiSsi34gg/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2fM88JkR3ZA5dJ8+EnLpWg95xXbRsFNcDjLXwrdZGhA=; b=R5U6b8X4ajD56AHIBSZHbeWexj
 GifQKtXwbQLPWrGrlCMNyIzCpFWGKGBZ2KgFE/h7W+is3VMcgt1my+tCov4wsUIFfKzMeu6yeJYWK
 AbnFlf9dUMeDtcO8PfUQgOZCbSc3Am/r/T9t+dH7qsHKn2DqMW/QFkBcYdQE1HCmUxPk=;
Received: from mail-yb1-f174.google.com ([209.85.219.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ogoFj-00Fpzm-5q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Oct 2022 14:23:03 +0000
Received: by mail-yb1-f174.google.com with SMTP id j7so5922514ybb.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 07 Oct 2022 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2fM88JkR3ZA5dJ8+EnLpWg95xXbRsFNcDjLXwrdZGhA=;
 b=ngKGLeZw9CyDozp6mhH3E6+a9FtNqfDGo49G1ogq76s7RYMMmOKfZHUijQIMis6UTn
 Fi3JKdHhCGn2719hZRUeg8GTpk1q4t8cKpUHBoOmPIIOMoiQhdWewEfgvfVZxboNQArK
 5Gn18JCzuwjUaXwAC0aQORqQ9O1LmLB+46iD80w7oOLX+UwRfaLpi2zpgOLoIjrTEn1H
 /nUu076Aqvd+mBg9cqbDCyWCWmesJ2QuveR42CE0kShWT3nPFiIJkLVANTYKQx0X4Tx0
 WnJUReob4IeU36iwEzUSB1JEfJh5fcjXDNdzgd7MlIZ/mHqUSlIqIpC64jE/5TgutdtW
 9g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2fM88JkR3ZA5dJ8+EnLpWg95xXbRsFNcDjLXwrdZGhA=;
 b=xda8EShLeGqRQjm7xbWH5ykDr6f5jTePd1sp/DuR2ETRuU+64jQDyhsoEbrBFiyDOT
 /qNw7DhjPF57JcCGUBj6qD5dJY8/zkZy8laXPTKJe2jtRTSM8xs6lYiCv7461/ywRxKD
 ewfq5tJ4ZtWh3h91okykx544ThHUpcgt4xJVnUfKlWxk2s76Ut/3sqrTdKAPG24UQWJ4
 6uFkH3SADsogL5s3PLcrWy4+JlvralphTGnpgozCadJgHMz5wYgNmjw/Bi5O2hJ5dRRy
 03h8m47cwhUFrv2J3B3O2zf36PMqSnoJk8YNIe+omO6CLbd5QgigQHCCHu7kGho+/BJ2
 blKA==
X-Gm-Message-State: ACrzQf0iBuYFkO6rc05AkLQ77JzXPPqXjEhu1pxs1xkxgIIRePgwuXC0
 Z/vV+J9skMK1b8axoBHcXU7i5oCyNoCaqYbA7q4=
X-Google-Smtp-Source: AMsMyM4VT4oaq5VaehMYvvRhdY7chdQWG7EOpRVLKHvBbSzxLX+C9sSYsB2IR9PE8G5wPuWKYmgOLra8W20gxTVBAFs=
X-Received: by 2002:a25:a0cd:0:b0:6bc:9569:b63e with SMTP id
 i13-20020a25a0cd000000b006bc9569b63emr5069657ybm.376.1665152577389; Fri, 07
 Oct 2022 07:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221004171351.3678194-1-daeho43@gmail.com>
 <b1ca9048-99c5-1ab4-fb77-5fe0bbc6d4de@kernel.org>
 <CACOAw_zXTHzc5mjPchGNXkgnswZLxLEBfRoEztB7VFdV-rtpwQ@mail.gmail.com>
 <4d7f250d-19c0-acd0-dde4-752f95c5fc2a@kernel.org>
In-Reply-To: <4d7f250d-19c0-acd0-dde4-752f95c5fc2a@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 7 Oct 2022 07:22:46 -0700
Message-ID: <CACOAw_weAbKWs6qi5x9t2=L41tVUV+CKjG-BGn1gOOtgjdWYug@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1ogoFj-00Fpzm-5q
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: correct i_size change for
 atomic writes
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

>
> Fine to me.
>
> But another question is, now it allows GC to migrate blocks belong
> to atomic files, so, during migration, it may update extent cache,
> once largest extent was updated, it will mark inode dirty, but after
> this patch, it may lose the extent change? thoughts?
>

Oh, I missed that case. Maybe we could prevent updating the i_size of
atomic files in f2fs_update_inode() while allowing inode dirtying.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
