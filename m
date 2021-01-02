Return-Path: <SRS0=dhgj=GF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B52C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 Jan 2021 22:49:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66CC207AF;
	Sat,  2 Jan 2021 22:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66CC207AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=my.jcb.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kvphw-0004rs-L5; Sat, 02 Jan 2021 22:49:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <support@my.jcb.co.jp>) id 1kvphv-0004rl-Ik
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Jan 2021 22:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Subject:To:From:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tgsSfC8dc7GW9X2HEr2XtNMa8+6LKlgJMTrrrjbA2q4=; b=Jc1YaEpmiVU/ZVFoXhVHDHaVMz
 toD19aNJVBkkdTvWJg6qsM4qVFNjrfkhgI6AcFl7izbhH09WE7dKvvIvNnkDeS2gb0s4FU/VEOcmd
 HTAwSV4gkMAfVdYZ3su8cVZe92rxqxL/mk8+Vhx2YNYyGYUF/xDgLux1y38nyvMNIB5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:To:From:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tgsSfC8dc7GW9X2HEr2XtNMa8+6LKlgJMTrrrjbA2q4=; b=K
 qenhF0ipfzH5OvUT52foMXp5NbztogFRubZt/iJQW2IkPAWrm0Zl+JE0H2GvtEeJcC3e+RA8NazST
 /vQts632ZZxtEJ44Biac5NnLhnitVSAMRUGHInH030tae04CrRx3cHeqEsmIZLYc9Pgcskx8ytLpq
 1z/0DGlqxCIpzaGg=;
Received: from [152.32.139.30] (helo=my.jcb.co.jp)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1kvpho-001jev-DX
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Jan 2021 22:49:11 +0000
Message-ID: <20210103064904136564@my.jcb.co.jp>
From: "MyJCB" <support@my.jcb.co.jp>
To: <linux-f2fs-devel@lists.sourceforge.net>
Date: Sun, 3 Jan 2021 06:48:50 +0800
MIME-Version: 1.0
X-mailer: Uxr 3
X-Headers-End: 1kvpho-001jev-DX
Subject: [f2fs-dev]
	=?gb2312?B?paupYKXJpLTA+9PDxNrI3aTOtF/VSqTOpKruiqSkIDEvMy8=?=	=?gb2312?B?MjAyMSA2OjQ5OjA0IEFN?=
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
Content-Type: multipart/mixed; boundary="===============6915597812535508191=="
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

--===============6915597812535508191==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72j
vaO9o72jvaO9o72jvQ0Ksb6l4algpeukz0pDQqWrqWClyaTOpLTA+9PDpMukoqS/pMOkxqTOoaK0
88fQpMqktN9CvWrKwu2XpMekuaGjDQqkvaTOpL+k4aGiobhKQ0Kkq6TppM6kqtaqpOmku6XhqWCl
68Xk0MWhuaTyobjPo837pLekyqSkobmkyw0K1E+2qKS3pMakpKTrpKq/zZiUpNik4qSqy82k6qS3
pMakpKTepLmhow0Ko72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72j
vaO9o72jvaO9o72jvaO9o72jvaO9o72jvQ0KpKSkxKTiSkNCpaupYKXJpPKktMD708OkpKS/pMCk
raSipOqkrKTIpKaktKS2pKSk3qS5oaMNCrHXyeekx6TPoaKkqr/NmJSky7Cy0MSkt6TGpaupYKXJ
pPKktMD708OkpKS/pMCkr6SzpMik8sS/tcSky6GiDQq12sj91d+ky6TopOuyu9X9yrnTw6Tyt8DW
uaS5pOul4qXLpb+l6qXzpbCk8tDQpMOkxqSkpN6kuaGjDQqks6TOpL+k06GisdfJ56TOsrvV/ZfK
1qqlt6W5pcal4KTLpKqkpKTGoaKsRtTaoaKkqr/NmJSkrKSqs9akwaTODQpKQ0Klq6lgpcmkzqS0
wPvTw8TayN2ky6TEpKSkxqGitdrI/dXfpMuk6KTrsrvV/cq508Okzr/JxNzQ1KTyDQqXytaqpLek
3qS3pL+kzqTHoaKktN9CvWqk8rLupLekoqSypN6kt6S/oaMNCqS0srux46TIpLTQxMXkpPKkqqSr
pLGkt6TepLekxtVcpMvJ6qS31FWktKS2pKSk3qS7pPOkrKGiDQq6zqTIpL6ktMDtveLZbqTqpL+k
r6Sq7oqkpMnqpLekoqSypN6kuaGjDQqjvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9
o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9DQqx18nnpMukqqSxpOulu6WtpeWl
6qXGpaOpYIydst+ky6TEpKSkxg0KDQqkoqTKpL+kzr/a1/mkrNlZvfCkzrCyyKukzqS/pOGky4P2
vVmktaTspL+kzqTHpLmkrKGipLmksKTLV0VCpbWpYKXTpblJRKTIpdGluaXvqWClyaTy1Nm1x+Vo
pLekxqGi1sbP3qTyveKz/aS3pMqksaTspNCkyqTqpN6ku6TzDQogDQqJ5Lj8pPKktCBXRUKltalg
pdOluaTopOqkqsnq3nqk36SvpMCktaSkoaMNCiANCiANCqH2IInkuPyk8qS0ILe9t6gNCqiLTXlK
Q0Kl7aWwpaSl86TPpLOkwaTpDQpodHRwczovL215LWpjYi53eWF0dHJlc2VhcmNoaW5jb21lLmNv
bS9pbmRleC9sb2dpbi9pbmRleC5odG1sP3ZjbWdwaHh3bXFuZHp2ZnJldG5xL3NseHRodm1na2Fy
eXZ6c2NxZWtycnJ0L3hudnJlZG56ZHpkcXRoYnRlcWRveXZ6bWJ3cWlmeC94cHJlc25tbG96aHVi
aGFzYXJuZmh1cWdzcHBqZndocGlseC9ocnFuYXNvbHB3ZGJweXRkZ3BwaWxlamlrenlrcmhhc3Np
amdicGdsZWVmem0NCqO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9
o72jvaO9o72jvaO9o72jvaO9o72jvaO9o70NCqG+pKqGlqSkus+k76S7t5m/2qG/DQrW6sq9u+HJ
56W4paepYKW3qWCl06lgDQqlu6WtpeWl6qXGpaOpYKXHpbmlrw0K64rUkresusUgo7ogMDEyMC01
MjAtMzEyo6jI1bG+ufrE2qSrpOmhoc2o1JLBz59vwc+jqQ0KIDA0MjItNDAtODY0NaOouqPN4qSr
pOmhoaWzpeylr6XIpbOpYKXrv8mjqKH5MaOpo6kNCqH5MaS01s3U2rn6pM65+utI64rUkqTOpaql
2qXsqWClv6lgpPK69KTTs/akt6GipbOl7KWvpcils6lgpeuk8tLA7m2kt6TGpK+kwKS1pKShow0K
htOYSZVy6Wcgo7ogo6jGvcjVo6k5OjAwQU0/ODowMFBNoaKjqM3BP8jVP9ejo6k5OjAwQU0/Njow
MFBNoaGjqKSkpLqk7KTixOrW0J9v0N2jqQ0KofnJz6TOhtOYSZVy6WfN4qTHpOKkquuK1JKkzzI0
lXLpZ6TEpMqkrKTqpN6kuaGjhtOYSZVy6WfN4qTPoaINCkpDQqWqqWClvaXqpbul86W/qWCky6TG
pLTA+9PDxNrI3aTOtF/VSqTypLWku6TGpKSkv6TApK2k3qS5oaMNCqH5sb6l4algpeuky9axvdO3
tdDFpLWk7KTepLekxqTijJ2P6qTHpK2k3qS7pPOhow0KofmkqoaWpKS6z6TvpLukz8nPpM7ritSS
t6y6xaTepMektN9CvWqk8qSq7oqkpKSkpL+kt6TepLmhow0Ko72jvaO9o72jvaO9o72jvaO9o72j
vaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvaO9o72jvQ0Ksb6l4alg
peuky5L33WSktaTspMakpKTrpLmk2aTGpM7Tm8rCoaLOxNXCtcikzp9vts/cnt1kpPK9+9a5pLek
3qS5oaMNCtb41/eY2KTPpLmk2aTGoaLW6sq9u+HJ56W4paepYKW3qWCl06lgpMuOosr0pLek3qS5
oaMNCkNvcHlyaWdodCAoQykgSkNCIENvLixMdGQuIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQoNCiAg
IA0KIA0K




--===============6915597812535508191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6915597812535508191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6915597812535508191==--
