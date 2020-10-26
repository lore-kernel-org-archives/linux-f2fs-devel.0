Return-Path: <SRS0=JrMS=EB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB44C4363A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:27:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735DC206C1;
	Mon, 26 Oct 2020 23:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ch+qq7S8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Q2xTE0LR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqMbf+cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735DC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXBtg-0008Vb-Q0; Mon, 26 Oct 2020 23:27:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kXBtf-0008VU-A2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:27:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8vfMmsVFUemh8lPXQF261JFlhfalPz+hbOSD8jGch8A=; b=ch+qq7S8rudfK6EkiSoeNbWe13
 VbYu9L47LbHPmSPT8xYtIe676telivZoz+FihicaHIw4AiSIrpKbJjWW6qt9zkrsl0DuPVdXV5oMI
 l55VZUJTQ02wj95hMe62uI15EKXNzQQPwV+f0HApETAnBn8BoGEpwcuiRlu/3I5DlEw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8vfMmsVFUemh8lPXQF261JFlhfalPz+hbOSD8jGch8A=; b=Q2xTE0LRSWkZGgyqUjjaOnojUp
 hO3r8VSgq7pCxtdRiLG13VPMbSAnJDeWlwBhGkcqP1Ib9gEf4lf9W7GzMgkSRxFdSbYi0DHsb/m85
 W94YZVR2gAkYlsJjJuzDu1iYDja0qljJf9FoaFgQLH2Mt29ee7Zx36zXp9WtDmoMmM7E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kXBtX-00EswE-Px
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Oct 2020 23:27:27 +0000
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37F7120809;
 Mon, 26 Oct 2020 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603754834;
 bh=7R6MsrFar+nmsUiiC6n6KOo/0FDbgQKAEj1UliSyDmw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RqMbf+cjR7kx1wnbJkfENG701riA0xCpQYOaDs2AOvIcuZGMbXFTZWa0ASd/BTFjp
 G2Jdy91akh+rfCm7qSr/U1JvBrR5PLTwTwLwy4Io1/ZkQQ0py8at5H4VdHyWeZRXDu
 iHjdCgxdiWb9ckqiX76UUOwiPdPhJEmlrewOZ+E0=
Date: Mon, 26 Oct 2020 16:27:12 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <20201026232712.GC1947033@gmail.com>
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
 <20201026230555.GB1947033@gmail.com>
 <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
X-Headers-End: 1kXBtX-00EswE-Px
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: add
 F2FS_IOC_GET_COMPRESS_OPTION ioctl
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

On Tue, Oct 27, 2020 at 08:18:44AM +0900, Daeho Jeong wrote:
> I checked that. We seem to need to complement missing parts including
> other ioctls in Documentation/filesystems/fscrypt.rst.
> 
> Thanks~
> 

Well, the f2fs-specific ioctls should probably be documented in
Documentation/filesystems/f2fs.rst.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
