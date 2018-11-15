From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix race between write_checkpoint
 and write_begin
Date: Thu, 15 Nov 2018 16:37:18 +0800
Message-ID: <a224ee4b-197d-ec96-fb70-275343fd85be@huawei.com>
References: <20181114113428.39780-1-shengyong1@huawei.com>
 <3e83ea0e-32ed-9281-15de-efd1bdf596dd@huawei.com>
 <0ab506b9-cbf3-a1d6-9984-c4e62c140c6d@huawei.com>
 <20181115082444.GB83610@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gND9i-0003DN-7G
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 15 Nov 2018 08:37:42 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gND9d-009Uka-5o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 15 Nov 2018 08:37:42 +0000
In-Reply-To: <20181115082444.GB83610@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/11/15 16:24, Jaegeuk Kim wrote:
> Could you please check this?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test

Reviewed +1

Thanks,
