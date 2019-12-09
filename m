Return-Path: <SRS0=FIoQ=Z7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A165C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:19:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14649206D5;
	Mon,  9 Dec 2019 22:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="G9oyGQfW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Kt9pCPaZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfl0by/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14649206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ieRN0-0000hW-UH; Mon, 09 Dec 2019 22:19:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1ieRMz-0000hN-Cb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Dec 2019 22:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zmwOaSeiAvLPzqG68TAN+ppRDb5X6499hrcsLH8lRAc=; b=G9oyGQfWk4wVTtqlOq22dERMKw
 RaCJIDSMF+bu4JuU0OmIfFBR8pKFmAXVPy/O2ai38zww9Ev+sSCU5ch1oO99+ERMmxhNFv8NehICp
 eDlyuZs2vn1cnOHgC3wXyQkst3XK8jj1sfLU+GyVBkuX28RpyFgOSIkUUEConAuQ1jIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zmwOaSeiAvLPzqG68TAN+ppRDb5X6499hrcsLH8lRAc=; b=K
 t9pCPaZGibBAujPlYI9Xtf67yCng+9WGj8eV6CsIvx69WMe7vqJ1P5hWqLeaal9e2Fy7cnQpW7zgK
 Gggf4xNYVVMe2+LrDOsT8sEt+ya5I8liU3tbmH6sGXU6xLiqWx3VbZ4l8RjXrFXbwfwaqxnd/9Shr
 5TD47EScMhRg+9Mo=;
Received: from mail-vs1-f49.google.com ([209.85.217.49])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1ieRMx-00FiMr-AG
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Dec 2019 22:19:09 +0000
Received: by mail-vs1-f49.google.com with SMTP id x18so11590591vsq.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Dec 2019 14:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zmwOaSeiAvLPzqG68TAN+ppRDb5X6499hrcsLH8lRAc=;
 b=Rfl0by/l0SpBnTijYE7emxyhe/nlHPGn5rl/AqX6argZ7I7gwstPMn3tZJaCRwMtd+
 E3qjVW+1m0EIAHh8FdI99YjpjkIuLhw/75lZ5b1HTFyrGQPL5MZbrohj/v0+nlBla15o
 FFADvp0tEXJn27zZ0tF0jrvkEYgY53tVx47TLFWR1OHE0dkYnfGBThJFfi/zZmfuioUr
 vW4wfuDnhAWG+/mUi9X/Ifyc8qVysH8QjksnJaiy0jrYp69/g8170gk0OjwZA+s+41Or
 1eGEFsPkcb1Hn00FjpCZSuCiudBXR+1SEP2jzfY7T7w6c48AicKmbsXlayzRIY1U9yJc
 zCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zmwOaSeiAvLPzqG68TAN+ppRDb5X6499hrcsLH8lRAc=;
 b=T4lnQ9mNqhPqE96/2ltf57LC4YbHhZbxJip77yAU3uJtskACatISQHHElIFPL/RywC
 1G5L7FoBqaYz/csqXkKycr7gdAMNykT52RLmPRNmrQTIB26KDJ1j7zjmad54lJDxVjop
 O0WNN5JDSOTfTraDp7T3GRkF7lvFes4oS9e/3x6GhnpWnfHDcvzgICi16xIMlxTpFKia
 Cb1MoXczpAHKTHoSrJhYuPE8+00pTmW8muQMpU8xP0k7pyIWK3uV3QJ4W9vmVlOR0P1j
 VPTI6blGuaMHRkgHra13YHNsAAdX/renouKBee2Sm+yDFf3M/+tImxRNWr9tjsiDXUnf
 iQFw==
X-Gm-Message-State: APjAAAWHdPF1G5NyjeiYztvdyY3Gzy/SbSn7iscpsLoO/2CM+/dTw9zo
 DKuSgWmaZGA+n9Y/x7g3XSodikraQEgxLdHXvtJVWo7iP/8=
X-Google-Smtp-Source: APXvYqzrCSBRiGifRP25gA4wUmpwp6tLVBRGRSr41Ujrnm1p8oUBG44Ptl1vJvqIOysLbpV8YNzpHsE5cphHXsPglxk=
X-Received: by 2002:a05:6102:21d8:: with SMTP id
 r24mr23351000vsg.83.1575929940921; 
 Mon, 09 Dec 2019 14:19:00 -0800 (PST)
MIME-Version: 1.0
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Tue, 10 Dec 2019 07:18:50 +0900
Message-ID: <CAD14+f0rw8wUBsN9Cs3Nrp03g40qOk_7AnrOiVSN98d5Ec7PsQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, 
 Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1ieRMx-00FiMr-AG
Subject: [f2fs-dev] f2fs: How should I use the defragmentation tools?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi everyone.

I've had interests in defragging f2fs for a long time now.

https://www.usenix.org/system/files/conference/atc17/atc17-hahn.pdf
This paper proves that defragmentation caused from the filesystem
takes a big portion of performance degradation.
(It'd be interesting to see whether f2fs would behave differently from
ext4 in terms of fragmentation.)

While doing defragmentation on a production device currently poses a
lot of practicality issues, I'd still like to try them out for
educational purposes.

However, I'm still not sure how to do defragmentation while f2fs
having 2 tools for that purpose.

1. Is either of `defrag.f2fs` or `f2fs_io defrag_file` meant to be
feature-parity with e4defrag?

2. What's the expected output from `defrag.f2fs` and `f2fs_io
defrag_file`? I'd like to get example outputs from you guys for me to
compare.

3. Is `defrag.f2fs` and `f2fs_io defrag_file` tested thoroughly?
Should I expect any potential corruptions from running these?

4. `defrag.f2fs` seems to only work on an unmounted block device.
What's the intended use-case scenario for this? I'm assuming running
`defrag.f2fs` and feeding the entire block length to -l is not how
it's meant to be used.

5. Why did you make it mandatory for the users to supply the lengths
to `f2fs_io defrag_file`? Is it any practical to defrag a part of a
file?

6. How exactly should I run `f2fs_io defrag_file`? My following
attempts failed with -EINVAL:
# ls -al session-02.pdf
-rw-rw-r--. 1 1023 1023 30517375 Nov  7 21:10 session-02.pdf
# f2fs_io defrag_file 0 30517375 session-02.pdf
F2FS_IOC_DEFRAGMENT failed: Invalid argument
# f2fs_io defrag_file 0 1048576 session-02.pdf
F2FS_IOC_DEFRAGMENT failed: Invalid argument

Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
