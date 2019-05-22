From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: always assume that the device is
 idle under gc_urgent
Date: Wed, 22 May 2019 20:10:57 +0800
Message-ID: <358ee0ea-02ba-346a-af95-ab949003cb15@kernel.org>
References: <20190514063623.57162-1-qkrwngud825@gmail.com>
 <20190514063623.57162-3-qkrwngud825@gmail.com>
 <20190521001137.GE61195@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1hTQ5P-0005Cm-VZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 May 2019 12:11:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hTQ5N-00GzeT-94
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 May 2019 12:11:11 +0000
In-Reply-To: <20190521001137.GE61195@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Park Ju Hyung <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2019-5-21 8:11, Jaegeuk Kim wrote:
> On 05/14, Park Ju Hyung wrote:
>> This allows more aggressive discards and balancing job to be done
>> under gc_urgent.
> 
> Let me merge this first. :)
> 
>>
>> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
