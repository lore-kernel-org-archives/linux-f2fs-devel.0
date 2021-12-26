Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBD5C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Dec 2021 09:30:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n1PrZ-0000kd-SE; Sun, 26 Dec 2021 09:30:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ele.mon@jllresort.com>) id 1n1PrY-0000kA-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Dec 2021 09:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2bRpGiCtBTIm3RfEo4wtCTqMMSXI9kP9qtSD2cVSo8=; b=UGWpoDNYy0R9MvX33JJEx4m0Sz
 Mb0/3dMiYqFWF9QVMSYKRF1IQ5mKGJxXh5RzbC4umcZbgJeyDOsNElGWZHFnfzi2eFd5aqMiQNdAa
 i29eWOvNPWj/97/AkuPtfL7zbg3NMri+W4ZLSOACfb3UYF10GH0aXhqIa9UpjgTFXhho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g2bRpGiCtBTIm3RfEo4wtCTqMMSXI9kP9qtSD2cVSo8=; b=N
 m1VfviXLLqZoy8D5r1uUoV5znmogXxXDSRxC3DFMd8UH0TyygbT+NrF/6CcomfVLoGz9aYUgX0OLw
 +05rnAVkNdslFcarrX9UUFCp/n9GGFb0G2YjfK44UqJyBFJHtT0lZIsD6wtt+eN1CqFr6N2brStIM
 mPUW5puk5wgxZmNM=;
Received: from slot0.jllresort.com ([62.197.136.5])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n1PrV-009iiI-TD
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Dec 2021 09:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=jllresort.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=ele.mon@jllresort.com; bh=11DHwLfcRJ3i4/T7bfhsm8foxA0=;
 b=V50TeXlhzkzHDrC6uZ8QguRAD9EQ3J+aPwSQIMgbIh1MI/xpR0EdjY3B4a9QJ17mQxnOfxehUJpZ
 FBWSAAQSvFug1dKH3v4PWTo0e/rSxwq5gOKfg3cpOAZiXRrWWL9BExtPz4TAsrxh5YOuTBq0CoKW
 YBMNARMxxtHACHrsVYFV3YRdnDj6CHQcPWM8aLal4B+ig/zRrVXg0uv5+QuJ8UQNOHs3oTreTkzk
 +i6LZ8J7krlbVqX2GR1yaxwQcpCPNDY1YtfxB3fcouFUTcC/AjQIvkn78jMfIeBI0EbZCWWeetsw
 W+SOMkptULpnJLly1N0MG5pWznMfMQh+R5BGTw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=jllresort.com;
 b=QfoRnHgxcTWNs/TSBP4sbzo/dal3X3XznaG7iT/7an94EvuZJS9+qGNToKaBs7rH7aqr5uQjjj3R
 IAL+G24iqiVa5dzOcVaSfk4ZT4xJRUvjkCzeziPg8ax8lh6SmyBTymJz8JtlnfM7GK0lqWYXYJ1T
 md98RvGve7GCsAdjuiYvfWvr1F8npfZNvOwjEAEpZaD+RuaW49UmLcamQD6tAuoD37EikndqQpX6
 ybbYswIizwlwgJnJpjkq2QEHfJe+KpB/LY8+fHGPaGKO8ROGg3E0oaLoGGigkRbhjQ7Mj0cfM4GY
 s3foZbyO8LqrpEWPX5cLpd2SFMdkHcFm2gzWKQ==;
From: ele.mon@jllresort.com
To: linux-f2fs-devel@lists.sourceforge.net
Date: 26 Dec 2021 10:29:30 +0100
Message-ID: <20211226102855.8ECE23B2243B2FEB@jllresort.com>
MIME-Version: 1.0
X-Headers-End: 1n1PrV-009iiI-TD
Subject: [f2fs-dev] Happy Weekend:
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
Reply-To: mustafa.ayvaz@ayvazburosu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Greetings to you linux-f2fs-devel,

I was wondering if you got my previous email? I have been trying 
to reach you by email linux-f2fs-devel@lists.sourceforge.net, 
kindly get back to me swiftly, it is very important and urgent.

Thanks
Mustafa Ayvaz
Email: mustafa.ayvaz@ayvazburosu.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
