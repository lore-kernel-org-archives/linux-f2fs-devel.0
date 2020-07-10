Return-Path: <SRS0=2C9g=AV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A964C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2020 03:41:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5182064B;
	Fri, 10 Jul 2020 03:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="af6v0Hzl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="i0/4PE+p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8bpLBun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5182064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jtjud-000109-1E; Fri, 10 Jul 2020 03:41:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jtjuc-000102-0N
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jul 2020 03:41:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mnLyuyxXqOw3ZWwQ1EA17YQXGcET0yeWq15W1hs3v0c=; b=af6v0HzlvW1AKeCmStWUaEPN6a
 BOwe7Bz620A+ivu0xEAVCg/Wy8/ZKQL/+A6/kMOUvwwEDFgFyzBiGrHM9aJD67Trwc5G+50PqD5Df
 EA+WgiX1UrzlmKV4jBu6LDHqMF5pIhmXLtYKFQ3TYnawY/kwFj0emQ17YaDKmkbURf0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mnLyuyxXqOw3ZWwQ1EA17YQXGcET0yeWq15W1hs3v0c=; b=i0/4PE+poohIH9CBSi5CXNl906
 MJAeVAPCq7ZqurgT/FFZ0YqQo+W1kL4B+sncR6Un8dgyYfusDC2fzHkRfDH8glbX13AHiZ71f/7fR
 kHE94Qwya6I8sXJVkG4CRhOC4WjY8/QuazEyc2wNrTsVJL+u9Um2+sXYkePwBPY9g3Nw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jtjua-00Cp8p-Pw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jul 2020 03:41:21 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 570EA2064B;
 Fri, 10 Jul 2020 03:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594352475;
 bh=GagPeJtDnMAQSjt9IhraoRKr/iChiaN0BYYltJz+bz8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G8bpLBunUsgGUG2TnXTAlsuzxi6dtlFMQukAE+loo6iD0d5PQ3EcAEZxlyDvUgG3u
 a9lIzemmOq21FMLR98K1I8IC6dH6zP+Py7GEUHbdSJgJ1i2t60ueU+UTKpU0is5spn
 ZChwKydbLC1Rrlh7zeY6PZIuulhKW5FQsCoKNGoc=
Date: Thu, 9 Jul 2020 20:41:14 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: lampahome <pahome.chen@mirlab.org>
Message-ID: <20200710034114.GG545837@google.com>
References: <CAB3eZftzcywNU-cf7mRWqtj-74VqgzLHC32a6v_CycVcRsiu0A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB3eZftzcywNU-cf7mRWqtj-74VqgzLHC32a6v_CycVcRsiu0A@mail.gmail.com>
X-Headers-End: 1jtjua-00Cp8p-Pw
Subject: Re: [f2fs-dev] possible to allocate a full segment for a direct IO
 with blocksize 2MB?
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/10, lampahome wrote:
> I create 3 dd job write 1GB file with directIO and blocksize is 2MB
> equal to segment size.
> 
> But it seems the each IO of three job's physical block address maybe
> in different segment.
> 
> If I can get full segment for one directIO, I thought performance will be up.
> 
> Is that possible?

How about using file pinning?

1. fd = create()
2. ioctl(fd, F2FS_IOC_SET_PIN_FILE)
3. fallocate(1GB)
 -> will allocate 2MB segments to the 1GB space
4. write(DIRECT_IO)
 -> will do in-place updates directly

You can use f2fs_io built by f2fs-tools for #2.
# f2fs_io pinfile set [file_path]

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
