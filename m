From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: data: fix warning Using plain integer as NULL
 pointer
Date: Mon, 8 Apr 2019 19:18:45 +0800
Message-ID: <d0d855ca-a7cd-9dcb-d7b1-b9fe03fffcc8@huawei.com>
References: <20190406105936.GA30585@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190406105936.GA30585@hari-Inspiron-1545>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/4/6 18:59, Hariprasad Kelam wrote:
> changed passing function argument "0 to NULL" to fix below sparse
> warning
> 
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
