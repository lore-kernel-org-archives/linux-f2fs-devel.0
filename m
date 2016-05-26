From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: Return the errno to the caller to avoid using a
 wrong page
Date: Thu, 26 May 2016 19:30:44 +0800
Message-ID: <5746DE64.2040908@huawei.com>
References: <1464181261-3980-1-git-send-email-yunlong.song@huawei.com>
 <1464237511-2181-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464237511-2181-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com
Cc: bintian.wang@huawei.com, houpengyang@huawei.com, heyunlei@huawei.com, liushuoran@huawei.com, shiguojun@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


>  page_hit:
> -	f2fs_bug_on(sbi, nid != nid_of_node(page));
> +	if(nid != nid_of_node(page)) {

should add "unlikely" here, will fix this in v3 patch.

> +		f2fs_bug_on(sbi, 1);
> +		ClearPageUptodate(page);
> +out_err:
> +		f2fs_put_page(page, 1);
> +		return ERR_PTR(-EIO);
> +	}
>  	return page;
>  }
>  
> 


-- 
Thanks,
Yunlong Song
